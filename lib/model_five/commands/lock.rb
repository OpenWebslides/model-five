# frozen_string_literal: true

module ModelFive
  module Commands
    ##
    # Lock an environment
    #
    class Lock < Command
      command 'lock' do |client, data, match|
        begin
          raise ModelFive::Error, 'No environment specified' unless match[:expression]

          env, *message = match[:expression].split(' ')
          reason = message.join ' '

          raise ModelFive::Error, "Environment *#{env}* not found" unless ModelFive.config.environments[env]
          raise ModelFive::Error, 'No reason specified' if message.empty?

          policy = Policies::Lock.new :user => data.user,
                                      :environment => env

          policy.authorize!
        rescue ModelFive::Error => e
          client.say :text => e,
                     :channel => data.channel
          next
        end

        locked, owner, reason_locked = ModelFive.lock_manager.locked? env

        if locked
          client.say :text => "Environment *#{env}* is already locked by <@#{owner}> because: *#{reason_locked}*",
                     :channel => data.channel
        else
          ModelFive.lock_manager.lock env, data.user, reason
          client.say :text => "Environment *#{env}* is now locked for *#{ModelFive.config.lock_lifetime} seconds* because: *#{reason}*",
                     :channel => data.channel
        end
      end
    end
  end
end
