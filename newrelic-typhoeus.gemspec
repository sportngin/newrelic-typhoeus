# -*- encoding: utf-8 -*-
require File.expand_path('../lib/newrelic-typhoeus/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Nate Greene"]
  gem.email         = ["nate.greene@sportngin.com"]
  gem.description   = %q{Newrelic instrumentation for Typhoeus}
  gem.summary       = %q{Newrelic instrumentation for Typhoeus}
  gem.homepage      = ""
  gem.license       = "MIT"
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "newrelic-typhoeus"
  gem.require_paths = ["lib"]
  gem.version       = Newrelic::Typhoeus::VERSION

  gem.add_runtime_dependency(%q<newrelic_rpm>, ["~> 3.0"])
  gem.add_runtime_dependency(%q<typhoeus>, ["~> 0.4.2"])
end
