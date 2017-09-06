# frozen_string_literal: true

require 'net/https'
require 'uri'

module ModelFive
  module Commands
    class Status < Command
      def self.execute(client, data, _match)
        text = []

        ModelFive.config.environments.marshal_dump.keys.each do |env|
          locked, owner, reason = ModelFive.lock_manager.locked? env.to_s

          text << (locked ? "*#{env}* - locked by <@#{owner}> because: *#{reason}*" : "*#{env}* - unlocked")
        end

        client.say :text => text.join("\n"),
                   :channel => data.channel
      end
    end
  end
end
