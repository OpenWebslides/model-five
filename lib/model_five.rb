# frozen_string_literal: true

require 'slack-ruby-bot'

require 'model_five/version'
require 'model_five/config'
require 'model_five/error'
require 'model_five/lock_manager'

require 'model_five/policies/deploy'
require 'model_five/policies/lock'

require 'model_five/commands/command'
require 'model_five/commands/joke'
require 'model_five/commands/ping'
require 'model_five/commands/version'
require 'model_five/commands/deploy'
require 'model_five/commands/log'
require 'model_five/commands/lock'
require 'model_five/commands/unlock'

require 'model_five/server/command'
require 'model_five/server/deploy'

require 'model_five/bot'

module ModelFive
  def self.root
    File.expand_path '../..', __FILE__
  end
end
