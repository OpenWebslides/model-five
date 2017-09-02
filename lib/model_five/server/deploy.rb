# frozen_string_literal: true

require 'net/ssh'

module ModelFive
  module Server
    class Deploy < Command
      def execute
        raise 'No block given' unless block_given?

        env = ModelFive.config.environments[@environment]

        command = "[[ -d #{env.path} ]] && cd #{env.path} && git fetch --all && git checkout `git rev-parse #{@branch}` && docker build -t openwebslides/openwebslides:latest . && docker-compose down; docker-compose up -d"

        Net::SSH.start env.host,
                       env.user,
                       :keys => [env.key] do |session|
          session.open_channel do |channel|
            channel.exec command do |ch, success|
              channel.on_request 'exit-status' do |ch, data|
                code = data.read_long

                yield "deploy *#{@branch}* to *#{@environment}* failed" unless code.zero?
              end
            end
          end

          session.loop
        end
      end
    end
  end
end
