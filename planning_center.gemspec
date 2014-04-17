# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'planning_center/version'

Gem::Specification.new do |spec|
  spec.name          = 'planning_center'
  spec.version       = PlanningCenter::VERSION
  spec.authors       = ['Mo Lawson']
  spec.email         = ['mo@molawson.com']
  spec.summary       = %q{Ruby wrapper for the Planning Center Online API.}
  spec.description   = %q{Ruby wrapper for the Planning Center Online API.}
  spec.homepage      = 'https://github.com/molawson/planning_center'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'oauth'
  spec.add_dependency 'json'

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'rubocop'

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'dotenv'
  spec.add_development_dependency 'awesome_print'
end
