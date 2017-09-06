# frozen_string_literal: true

module ModelFive
  module Commands
    class Log < Command
      def self.execute(client, data, match)
        raise ModelFive::Error, 'No environment specified' unless match[:expression]

        id = match[:expression].split(' ').first
        path = ModelFive.redis.get "#{id}_log"

        raise ModelFive::Error, "Deployment *#{id}* not found" unless path
        raise ModelFive::Error, 'Log file not found' unless File.exist? path
        raise ModelFive::Error, 'Log file is empty' if File.empty? path

        client.web_client.files_upload :channels => data.channel,
                                       :as_user => true,
                                       :file => Faraday::UploadIO.new(path, 'text/plain'),
                                       :title => "Deployment log ##{id}",
                                       :filename => "deployment_#{id}.txt"
      end
    end
  end
end
