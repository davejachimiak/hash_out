module HashOut
  class CallRegistry < Struct.new :hash_out_caller
    include InitAttrs

    init_accessor :times_called, ->{ 0 }

    def register_call
      self.times_called += 1
    end

    def delete_caller_from hash
      hash.delete hash_out_caller  if internal_call?
    end

    def internal_call?
      times_called > 1
    end
  end
end
