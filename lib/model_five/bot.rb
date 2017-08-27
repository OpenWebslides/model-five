# frozen_string_literal: true

module ModelFive
  ##
  # Bot definition
  #
  class Bot < SlackRubyBot::Bot
    help do
      title 'Open Webslides Unit Model Five'
      desc 'Model Five manages deployments for you'
    end
  end
end
