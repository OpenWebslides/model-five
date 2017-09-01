# frozen_string_literal: true

module ModelFive
  module Server
    class Command
      attr_accessor :branch,
                    :environment

      def initialize(branch, environment)
        @branch = branch
        @environment = environment
      end

      def execute
        raise 'Not implemented'
      end
    end
  end
end
