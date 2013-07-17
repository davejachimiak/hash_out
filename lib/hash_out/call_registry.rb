module HashOut
  class CallRegistry
    attr_reader :times_called, :hash_out_caller

    def initialize hash_out_caller
      @times_called    = 0
      @hash_out_caller = hash_out_caller
    end

    def register_call
      @times_called += 1
    end
  end
end
