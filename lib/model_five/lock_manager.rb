# frozen_string_literal: true

require 'thread'

module ModelFive
  class LockManager
    attr_accessor :locks,
                  :mutex

    def initialize
      @locks = Hash.new
      @mutex = Mutex.new
    end

    def locked?(key)
      return false unless locks.has_key? key

      if (locks[key][:timestamp] + ModelFive.config.lock_lifetime) < Time.now.to_i
        # Stale lock
        locks.delete key

        return false
      end

      return true, locks[key][:owner]
    end

    def lock(key, owner)
      @mutex.synchronize do
        return false if locked? key

        locks[key] = {
          :owner => owner,
          :timestamp => Time.now.to_i
        }

        true
      end
    end

    def unlock(key, owner)
      @mutex.synchronize do
        return false unless locked?(key) && locks[key][:owner] == owner

        locks.delete key

        true
      end
    end
  end
end
