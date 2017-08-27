# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'model_five/version'

Gem::Specification.new do |spec|
  spec.name          = 'model_five'
  spec.version       = ModelFive::VERSION
  spec.authors       = ['Florian Dejonckheere']
  spec.email         = ['florian@floriandejonckheere.be']
  spec.summary       = 'Open Webslides Unit Model Five'
  spec.description   = 'Your friendly neighbourhood robot'
  spec.homepage      = 'https://github.com/OpenWebslides/model_five'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rubocop', '~> 0.48'
  spec.add_development_dependency 'rspec', '~> 3.6'
  spec.add_development_dependency 'factory_girl', '~> 4.8'
  spec.add_development_dependency 'faker', '~> 1.7'
end
