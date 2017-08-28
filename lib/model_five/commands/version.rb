# frozen_string_literal: true

module ModelFive
  module Commands
    class Version < Command
      command 'version'

      def self.call(client, data, _match)
        gemspec = Gem::Specification.find_by_name 'model_five'

        client.say :text => "#{gemspec.summary} #{gemspec.version} reporting for duty",
                   :channel => data.channel
      end
    end
  end
end
