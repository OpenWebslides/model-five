# frozen_string_literal: true

module ModelFive
  module Commands
    class Deploy < Command
      command 'deploy' do |client, data, match|
        begin
          expr = /^((?<branch>\w*)( to (?<env>\w*))?)?$/.match match[:expression]

          # Default branch and environment
          branch = (expr && expr[:branch]) || 'master'
          env = (expr && expr[:env]) || 'dev'

          raise ModelFive::Error, "Environment *#{env}* not found" unless ModelFive.config.environments[env]

          policy = Policies::Deploy.new :user => data.user,
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
