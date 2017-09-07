# frozen_string_literal: true

require 'tempfile'
require 'erb'

module ModelFive
  module Server
    class Deploy < Command
      attr_accessor :id

      def initialize(branch, environment, user)
        super branch, environment, user

        @id = ModelFive.redis.incr 'deploy_id'
      end

      def execute
        raise 'No block given' unless block_given?

        env = ModelFive.config.environments[@environment]
        command = ERB.new(File.read File.join ModelFive.root, 'deploy.sh.erb').result binding

        raise "No such private key: #{env.key}" unless File.exist? env.key

        log = Tempfile.new
        ModelFive.redis.set "#{id}_log", log.path

        yield "started deploy *#{@branch}* to *#{@environment}*"

        Thread.new do
          ModelFive.lock_manager.lock @environment, @user, "deploying #{@branch}"

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

                channel.on_request 'exit-signal' do |_ch, data|
                  yield "command received signal *#{data.read_string}*"
                end

                channel.on_request 'exit-status' do |_ch, data|
                  code = data.read_long

                  log.close

                  if code.zero?
                    yield 'deployment completed succesfully'
                  else
                    yield "command exited with exit status *#{code}*"
                    yield "deploy *#{@branch}* to *#{@environment}* failed"
                    yield 'use the *log* command to show the execution log'
                  end
                end
              end
            end

            session.loop

            ModelFive.lock_manager.unlock @environment, @user
          end
        end
      end
    end
  end
end
