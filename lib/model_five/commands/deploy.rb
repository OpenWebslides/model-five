# frozen_string_literal: true

module ModelFive
  module Commands
    class Deploy < Command
      match(/deploy( (?<branch>\w*))?( to (?<env>\w*))?$/) do |client, data, match|
        # Default branch and environment
        branch = match[:branch] || 'master'
        env = match[:env] || 'dev'

        begin
          policy = Policy.new :user => data.user,
                              :channel => data.channel,
                              :branch => branch,
                              :environment => env

          policy.authorize!
        rescue ModelFive::Error => e
          client.say :text => e,
                     :channel => data.channel
          next
        end

        deploy = Server::Deploy.new branch, env

        # Start async deploy
        Thread.new do
          deploy.execute do |msg|
            client.say :text => "<@#{data.user}>: [##{deploy.id}] #{msg}",
                       :channel => data.channel
          end
        end
      end
    end
  end
end
