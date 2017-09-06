# frozen_string_literal: true

require 'net/https'
require 'uri'

module ModelFive
  module Commands
    class Joke < Command
      def self.execute(client, data, _match)
        uri = URI.parse 'https://icanhazdadjoke.com/'

        http = Net::HTTP.new uri.host, uri.port
        http.use_ssl = true
        request = Net::HTTP::Get.new uri.request_uri
        request['Accept'] = 'text/plain'
        request['User-Agent'] = 'Model Five (https://github.com/OpenWebslides/model-five)'

        response = http.request request
        response.body.force_encoding 'UTF-8'

        client.say :text => response.body, :channel => data.channel
      end
    end
  end
end
