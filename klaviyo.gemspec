# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'klaviyo/version'

Gem::Specification.new do |spec|
  spec.name          = "parallel588-klaviyo"
  spec.version       = Klaviyo::VERSION
  spec.authors       = ["Maxim Pechnikov"]
  spec.email         = ["parallel588@gmail.com"]
  spec.summary     = 'You heard us, a Ruby wrapper for the Klaviyo API'
  spec.description = 'Ruby wrapper for the Klaviyo API'
  spec.homepage      = 'https://www.klaviyo.com/'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency('virtus', '>= 1.0')
  spec.add_runtime_dependency('json', '>= 1.7')
  spec.add_runtime_dependency('faraday', '~> 0.15.4')
  spec.add_runtime_dependency('multi_json', '~> 1.13')
  spec.add_runtime_dependency('activesupport', ['>= 3.1', '< 6.0'])

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry', '~> 0.10.3'
  spec.add_development_dependency 'webmock', '~> 2.0', '>= 2.0.3'
end
