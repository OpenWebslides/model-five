# frozen_string_literal: true

module ModelFive
  module Policies
    class Lock
      attr_accessor :user,
                    :environment

      def initialize(attrs)
        @user = attrs[:user]
        @environment = attrs[:environment]
      end

      def authorize!
        env = ModelFive.config.environments[@environment]
        raise ModelFive::Error, "Environment _#{@environment}_ not found" unless env

        # Restrict users
        user_allowed = env.allowed_users.include? user
        raise ModelFive::Error, "<@#{@user}> not allowed to (un-)lock *#{@environment}*" unless user_allowed
      end
    end
  end
end
