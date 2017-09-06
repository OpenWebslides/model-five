# frozen_string_literal: true

module ModelFive
  module Commands
    class Deploy < Command
      def self.execute(client, data, match)
        expr = /^((?<branch>\w*)( to (?<env>\w*))?)?$/.match match[:expression]

        # Default branch and environment
        branch = (expr && expr[:branch]) || 'master'
        env = (expr && expr[:env]) || 'dev'

        raise ModelFive::Error, "Environment *#{env}* not found" unless ModelFive.config.environments[env]

        policy = Policies::Deploy.new :user => data.user,
                                      :branch => branch,
                                      :environment => env

        policy.authorize!

        # Start async deploy
        Thread.new do
          locked, owner, reason_locked = ModelFive.lock_manager.locked? env

          if locked
            client.say :text => "Environment *#{env}* is already locked by <@#{owner}>: *#{reason_locked}*",
                       :channel => data.channel
          else
            ModelFive.lock_manager.lock env, data.user, "deploying #{branch}"

            deploy = Server::Deploy.new branch, env

            deploy.execute do |msg|
              client.say :text => "<@#{data.user}>: [##{deploy.id}] #{msg}",
                         :channel => data.channel
            end

            ModelFive.lock_manager.unlock env, data.user
          end
        end
      end
    end
  end
end
