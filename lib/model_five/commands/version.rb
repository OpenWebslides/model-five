# frozen_string_literal: true

module ModelFive
  module Commands
    class Version < Command
      command 'version' do |client, data, _match|
        client.say :text => "Open Webslides Unit Model Five #{ModelFive::VERSION} reporting for duty",
                   :channel => data.channel
      end
    end
  end
end
