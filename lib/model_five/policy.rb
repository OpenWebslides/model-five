# frozen_string_literal: true

module ModelFive
  class Policy
    attr_accessor :user,
                  :channel,
                  :branch,
                  :environment

    def initialize(attrs)
      @user = attrs[:user]
      @channel = attrs[:channel]
      @branch = attrs[:branch]
      @environment = attrs[:environment]
    end

    def authorize!
      env = ModelFive.config.environments[@environment]
      raise ModelFive::Error, "Environment _#{@environment}_ not found" unless env

      # Restrict channels
      channel_allowed = env.allowed_channels.include? @channel
      raise ModelFive::Error, "<@#{@user}> not allowed to deploy *#{@branch}* to *#{@environment}* from <##{@channel}>" unless channel_allowed

      # Restrict users
      user_allowed = env.allowed_users.include? user
      raise ModelFive::Error, "<@#{@user}> not allowed to deploy *#{@branch}* to *#{@environment}*" unless user_allowed
    end
  end
end
