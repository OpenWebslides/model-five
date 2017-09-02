# frozen_string_literal: true

module ModelFive
  module Commands
    class Log < Command
      match(/log (?<id>[0-9]*)$/) do |client, data, match|
        path = ModelFive.redis.get "#{match[:id]}_log"

        unless path
          client.say :text => 'No such deployment',
                     :channel => data.channel

          next
        end

        unless File.exist? path
          client.say :text => 'Log file not found',
                     :channel => data.channel

          next
        end

        client.web_client.files_upload :channels => data.channel,
                                       :as_user => true,
                                       :file => Faraday::UploadIO.new(path, 'text/plain'),
                                       :title => "Deployment log ##{match[:id]}",
                                       :filename => "deployment_#{match[:id]}.log"
      end
    end
  end
end
