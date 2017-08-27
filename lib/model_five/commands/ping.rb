# frozen_string_literal: true

module ModelFive
  module Commands
    class Ping < Command
      command 'ping'

      help do
        title 'ping'
        desc 'play ping pong'
      end

      def self.call(client, data, _)
        client.say :text => 'pong', :channel => data.channel
      end
    end
  end
end
