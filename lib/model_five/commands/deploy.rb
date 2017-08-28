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
        unless ModelFive.config.channel_ids.include? data.channel
          client.say :text => "<@#{data.user}>: not allowed to deploy from <##{data.channel}>",
                     :channel => data.channel

          next
        end

        branch = match[:branch] || CONFIG[:branch]
        env = match[:env] || CONFIG[:env]

        client.say :text => "<@#{data.user}>: started deploy *#{branch}* to *#{env}*",
                   :channel => data.channel
      end
    end
  end
end
