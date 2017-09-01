# frozen_string_literal: true

require 'yaml'
require 'recursive-open-struct'

module ModelFive
  def self.config
    @config ||= RecursiveOpenStruct.new(YAML.load_file(File.join __dir__, '..', '..', 'config', 'model_five.yml'))
  end
end
