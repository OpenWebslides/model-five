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

  spec.add_runtime_dependency 'slack-ruby-bot'
  spec.add_runtime_dependency 'celluloid-io'
  spec.add_runtime_dependency 'recursive-open-struct'

  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'factory_girl'
  spec.add_development_dependency 'faker'
  spec.add_development_dependency 'debase', '0.2.1'
  spec.add_development_dependency 'ruby-debug-ide'
end
