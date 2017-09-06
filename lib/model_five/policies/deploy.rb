# frozen_string_literal: true

module ModelFive
  module Policies
    class Deploy
      attr_accessor :user,
                    :branch,
                    :environment

      def initialize(attrs)
        @user = attrs[:user]
        @branch = attrs[:branch]
        @environment = attrs[:environment]
      end

      def authorize!
        env = ModelFive.config.environments[@environment]
        raise ModelFive::Error, "Environment _#{@environment}_ not found" unless env

        # Restrict users
        user_allowed = env.allowed_users.include? user
        raise ModelFive::Error, "<@#{@user}> not allowed to deploy *#{@branch}* to *#{@environment}*" unless user_allowed
      end
    end
  end
end
