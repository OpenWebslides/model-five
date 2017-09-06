# frozen_string_literal: true

module ModelFive
  module Commands
    class Ping < Command
      def self.execute(client, data, _match)
        client.say :text => 'pong',
                   :channel => data.channel
      end
    end
  end
end
