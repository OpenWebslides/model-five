# frozen_string_literal: true

module ModelFive
  module Commands
    class Unlock < Command
      match(/unlock (?<env>\w+)$/) do |client, data, match|
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

        if locked && owner == data.user
          if ModelFive.lock_manager.unlock match[:env], data.user
            client.say :text => "*#{match[:env]}* is now unlocked",
                       :channel => data.channel
          else
            client.say :text => "*#{match[:env]}* is locked by <@#{owner}>",
                       :channel => data.channel
          end
        else
          client.say :text => "*#{match[:env]}* is not locked",
                     :channel => data.channel
        end
      end
    end
  end
end
