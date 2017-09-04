# frozen_string_literal: true

require 'yaml'
require 'recursive-open-struct'
require 'redis'

module ModelFive
  def self.config
    @config ||= RecursiveOpenStruct.new(YAML.load_file(File.join __dir__, '..', '..', 'config', 'model_five.yml'))
  end

  def self.redis
    @redis ||= Redis.new
  end

  def self.lock_manager
    @lock_manager ||= ModelFive::LockManager.new
  end
end
