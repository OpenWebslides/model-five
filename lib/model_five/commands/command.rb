# frozen_string_literal: true

module ModelFive
  module Commands
    ##
    # Base command class
    #
    class Command < SlackRubyBot::Commands::Base
      def self.inherited(subclass)
        command subclass.name.demodulize.downcase do |client, data, match|
          begin
            subclass.send :execute, client, data, match
          rescue ModelFive::Error => e
            client.say :text => e,
                       :channel => data.channel
          rescue => e
            client.say :text => "Uh oh! An error occurred while processing this command: #{e}",
                       :channel => data.channel
          end
        end
      end
    end
  end
end
