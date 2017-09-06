# frozen_string_literal: true

module ModelFive
  module Commands
    ##
    # Lock an environment
    #
    class Lock < Command
      command 'lock' do |client, data, match|
        unless match[:expression]
          client.say :text => 'No environment specified',
                     :channel => data.channel
        end

        env = match[:expression].split(' ').first

        unless ModelFive.config.environments[env]
          client.say :text => "Environment *#{env}* not found",
                     :channel => data.channel
        end

        begin
          policy = Policies::Lock.new :user => data.user,
                                      :environment => env

          policy.authorize!
        rescue ModelFive::Error => e
          client.say :text => e,
                     :channel => data.channel
          next
        end

        locked, owner = ModelFive.lock_manager.locked? env

        if locked
          client.say :text => "Environment *#{env}* is already locked by <@#{owner}>",
                     :channel => data.channel
        else
          ModelFive.lock_manager.lock env, data.user
          client.say :text => "Environment *#{env}* is now locked for *#{ModelFive.config.lock_lifetime} seconds*",
                     :channel => data.channel
        end
      end
    end
  end
end
