# frozen_string_literal: true

module ModelFive
  ##
  # Bot definition
  #
  class Bot < SlackRubyBot::Bot
    help do
      title 'Open Webslides Unit Model Five'
      desc 'Model Five manages deployments for you'

      command 'ping' do
        title 'ping'
        desc 'play ping pong'
      end

      command 'joke' do
        title 'joke'
        desc 'tell me a joke'
      end

      command 'version' do
        title 'version'
        desc 'show bot version'
      end

      command 'deploy' do
        title 'deploy'
        desc 'deploy the app'
        long_desc 'command format: deploy [branch] to <environment>'
      end

      command 'log' do
        title 'log'
        desc 'show deployment log'
        long_desc 'command format: log <id>'
      end

      command 'lock' do
        title 'lock'
        desc 'lock an environment'
        long_desc 'command format: lock <environment>'
      end

      command 'unlock' do
        title 'unlock'
        desc 'unlock an environment'
        long_desc 'command format: unlock <environment>'
      end
    end
  end
end
