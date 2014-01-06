# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rocks/version'

Gem::Specification.new do |spec|
  spec.name          = "rocks"
  spec.version       = Rocks::VERSION
  spec.authors       = ["Alexander R Hill"]
  spec.email         = ["alexreedhill@gmail.com"]
  spec.description   = %q{A Rack-based Web Framework not for the faint of heart. Continue at your own risk.}
  spec.summary       = %q{A Rack-based Web Framework not for the faint of heart.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_runtime_dependency "rest-client"
  spec.add_runtime_dependency "rack"
  spec.add_runtime_dependency "erubis"
  spec.add_runtime_dependency "multi_json"
  spec.add_development_dependency "rack-test"
end
