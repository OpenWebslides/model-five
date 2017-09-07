# frozen_string_literal: true

module ModelFive
  module Server
    class Command
      attr_accessor :branch,
                    :environment,
                    :user

      def initialize(branch, environment, user)
        @branch = branch
        @environment = environment
        @user = user
      end

      def execute
        raise 'Not implemented'
      end
    end
  end
end
