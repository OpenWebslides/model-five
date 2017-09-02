# frozen_string_literal: true

require 'net/ssh'
require 'tempfile'

module ModelFive
  module Server
    class Deploy < Command
      attr_accessor :id

      def initialize(branch, environment)
        super branch, environment

        @id = ModelFive.redis.incr 'deploy_id'
      end

      def execute
        raise 'No block given' unless block_given?

        env = ModelFive.config.environments[@environment]

        command = "[[ -d #{env.path} ]] && cd #{env.path} && git fetch --all && git checkout `git rev-parse #{@branch}` && docker build -t openwebslides/openwebslides:latest . && docker-compose down; docker-compose up -d"

        log = Tempfile.new
        ModelFive.redis.set "#{id}_log", log.path

        Net::SSH.start env.host,
                       env.user,
                       :keys => [env.key] do |session|
          session.open_channel do |channel|
            channel.exec command do |_ch, success|
              yield 'could not execute command' unless success

              # STDOUT
              channel.on_data do |_ch, data|
                log.write data
              end

              # STDERR
              channel.on_extended_data do |_ch, _type, data|
                log.write data
              end

              channel.on_request 'exit-signal' do |ch, data|
                yield "command received signal *#{data.read_string}*"
              end

              channel.on_request 'exit-status' do |ch, data|
                code = data.read_long

                unless code.zero?
                  log.close

                  yield "command exited with signal *#{code}*"
                  yield "deploy *#{@branch}* to *#{@environment}* failed"
                  yield 'use the _log_ command to show the execution log'
                end
              end
            end
          end

          session.loop
        end
      end
    end
  end
end
