module HashOut
  class CallRegistry
    attr_reader :hash_out_caller

    def initialize hash_out_caller
      @times_called    = 0
      @hash_out_caller = hash_out_caller
    end

    def register_call
      @times_called += 1
    end

    def internal_call?
      @times_called > 1
    end

    def delete_caller hash
      hash.delete hash_out_caller if internal_call?
    end
  end
end
