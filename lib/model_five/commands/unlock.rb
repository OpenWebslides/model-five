# frozen_string_literal: true

module ModelFive
  module Commands
    class Unlock < Command
      command 'unlock' do |client, data, match|
        begin
          raise ModelFive::Error, 'No environment specified' unless match[:expression]

          env = match[:expression].split(' ').first

          raise ModelFive::Error, "Environment *#{env}* not found" unless ModelFive.config.environments[env]

          policy = Policies::Lock.new :user => data.user,
                                      :environment => env

          policy.authorize!
        rescue ModelFive::Error => e
          client.say :text => e,
                     :channel => data.channel
          next
        end

        locked, owner, reason_locked = ModelFive.lock_manager.locked? env

        if locked && owner == data.user
          if ModelFive.lock_manager.unlock env, data.user
            client.say :text => "Environment *#{env}* is now unlocked",
                       :channel => data.channel
          else
            client.say :text => "Environment *#{env}* is locked by <@#{owner}> because: *#{reason_locked}*",
                       :channel => data.channel
          end
        else
          client.say :text => "Environment *#{env}* is not locked",
                     :channel => data.channel
        end
      end
    end
  end
end
