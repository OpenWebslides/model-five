# frozen_string_literal: true

module ModelFive
  module Commands
    class Deploy < Command
      CONFIG = {
        # Default branch
        :branch => 'master',

        # Default environment
        :env => 'dev'
      }

      match(/deploy( (?<branch>\w*))?( to (?<env>\w*))?$/) do |client, data, match|
        branch = match[:branch] || CONFIG[:branch]
        env = match[:env] || CONFIG[:env]

        client.say :text => "@channel <@#{data.user}> started deploying #{branch} to #{env}",
                   :channel => data.channel
      end
    end
  end
end
