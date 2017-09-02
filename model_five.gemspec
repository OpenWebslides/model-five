# frozen_string_literal: true

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
end
