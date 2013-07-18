require 'set'

module HashOut
  module Excludable
    def exclusions
      @exclusions ||= Set.new
    end

    def exclude_from_hash_out
      exclusions.add last_call
    end

    def prepare_exclusions methods
      methods.each { |method| send method }
    end

    def delete_exclusions methods
      exclusions.each { |method| methods.delete method }
    end
  end
end
