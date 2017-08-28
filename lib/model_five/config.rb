# frozen_string_literal: true

module ModelFive
  def self.config
    @config ||= Config.new
  end

  class Config
    attr_accessor :admin_ids, :channel_ids

    def initialize
      @admin_ids = (ENV['SLACK_ADMIN_IDS'] || '').split ','
      @channel_ids = (ENV['SLACK_CHANNEL_IDS'] || '').split ','
    end
  end
end
