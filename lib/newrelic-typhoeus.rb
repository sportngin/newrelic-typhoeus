require "newrelic-typhoeus/version"

module Newrelic
  module Typhoeus
    DependencyDetection.defer do
      @name = :typhoeus

      depends_on do
        defined?(::Typhoeus)
      end

      executes do
        NewRelic::Agent.logger.debug 'Installing Typhoeus instrumentation'
      end

      executes do
        [::Typhoeus, ::Typhoeus::Request].each do |typhoeus|
          typhoeus.instance_eval do
            %w[post get put delete options head patch].each do |http_method|
              if respond_to?(http_method)
                define_singleton_method "#{http_method}_with_newrelic_trace" do |*args|
                  uri = URI.parse(args.first)
                  metrics = ["External/#{uri.host}/Typhoeus/#{http_method.capitalize}","External/#{uri.host}/all"]
                  if NewRelic::Agent::Instrumentation::MetricFrame.recording_web_transaction?
                    metrics << "External/allWeb"
                  else
                    metrics << "External/allOther"
                  end
                  self.class.trace_execution_scoped metrics do
                    send("#{http_method}_without_newrelic_trace", *args)
                  end
                end
                eigenclass = class << self; self; end
                eigenclass.alias_method_chain "#{http_method}", :newrelic_trace
              end
            end
          end
        end
      end
    end
  end
end
