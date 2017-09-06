# frozen_string_literal: true

module ModelFive
  module Commands
    class Lock < Command
      match(/lock (?<env>\w+)$/) do |client, data, match|
        begin
          policy = Policies::Lock.new :user => data.user,
                                      :environment => match[:env]

          policy.authorize!
        rescue ModelFive::Error => e
          client.say :text => e,
                     :channel => data.channel
          next
        end

        locked, owner = ModelFive.lock_manager.locked? match[:env]

        if locked
          client.say :text => "*#{match[:env]}* is already locked by <@#{owner}>",
                     :channel => data.channel
        else
          ModelFive.lock_manager.lock match[:env], data.user
          client.say :text => "*#{match[:env]}* is now locked for *#{ModelFive.config.lock_lifetime} seconds*",
                     :channel => data.channel
        end
      end
    end
  end
end
