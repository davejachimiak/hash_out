module HashOut
  module Excludable
    include LastCall

    def exclusions
      @exclusions ||= []
    end

    def exclude_from_hash_out
      exclusions.push last_call
    end

    def exclude_exclusions_from methods
      execute methods
      delete_exclusions_from methods
    end

    private

    def execute methods
      methods.each { |method| send method }
    end

    def delete_exclusions_from methods
      methods.delete_if { |method| exclusions.include? method }
    end
  end
end
