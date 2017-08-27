# frozen_string_literal: true

module ModelFive
  module Commands
    class Ping < SlackRubyBot::Commands::Base
      command 'ping' do |client, data, _|
        client.say :text => 'pong', :channel => data.channel
      end
    end
  end
end
