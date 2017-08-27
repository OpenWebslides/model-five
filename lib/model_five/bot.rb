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

      command 'deploy' do
        title 'deploy'
        desc 'deploy the app'
        long_desc 'command format: deploy [branch] to <dev | prod>'
      end
    end
  end
end
