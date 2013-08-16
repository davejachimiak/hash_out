require 'hash_out/excludable'

module HashOut
  module DelegatorExcludable
    include Excludable

    def exclusions
      @exclusions ||= self.class.delegators
    end
  end
end
