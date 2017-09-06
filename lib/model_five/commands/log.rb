# frozen_string_literal: true

module ModelFive
  module Commands
    class Log < Command
      command 'log' do |client, data, match|
        begin
          raise ModelFive::Error, 'No environment specified' unless match[:expression]

          id = match[:expression].split(' ').first
          path = ModelFive.redis.get "#{id}_log"

          raise ModelFive::Error, "Deployment *#{id}* not found" unless path

          unless File.exist? path
            client.say :text => 'Log file not found',
                       :channel => data.channel

            next
          end
        rescue ModelFive::Error => e
          client.say :text => e,
                     :channel => data.channel
          next
        end

        if File.empty? path
          client.say :text => 'Log file is empty',
                     :channel => data.channel

          next
        end

        client.web_client.files_upload :channels => data.channel,
                                       :as_user => true,
                                       :file => Faraday::UploadIO.new(path, 'text/plain'),
                                       :title => "Deployment log ##{id}",
                                       :filename => "deployment_#{id}.txt"
      end
    end
  end
end
