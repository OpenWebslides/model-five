# frozen_string_literal: true

require 'net/ssh'

module ModelFive
  module Server
    class Deploy < Command
      def execute
        env = ModelFive.config.environments[@environment]

        Net::SSH.start env.host,
                       env.user,
                       :keys => [env.key] do |session|
          session.exec 'hostname'

          session.loop
        end
      end
    end
  end
end
