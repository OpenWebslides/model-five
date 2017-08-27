# frozen_string_literal: true

module ModelFive
  module Commands
    class Ping < Command
      command 'ping'

      def self.call(client, data, _match)
        client.say :text => 'pong', :channel => data.channel
      end
    end
  end
end
