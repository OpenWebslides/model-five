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
        # Permit deploy only on restricted channels
        unless ModelFive.config.channel_ids.include? data.channel
          client.say :text => "<@#{data.user}>: not allowed to deploy from <##{data.channel}>",
                     :channel => data.channel

          next
        end

        branch = match[:branch] || CONFIG[:branch]
        env = match[:env] || CONFIG[:env]

        # Permit deploy to master only for restricted users
        if env == 'prod'
          unless ModelFive.config.admin_ids.include? data.user
            client.say :text => "<@#{data.user}>: not allowed to deploy *#{branch}* to *#{env}*",
                       :channel => data.channel

            next
          end
        end

        client.say :text => "<@#{data.user}>: started deploy *#{branch}* to *#{env}*",
                   :channel => data.channel
      end
    end
  end
end
