require 'attr_setter'

module HashOut
  class CallRegistry < Struct.new :hash_out_caller
    include AttrSetter

    attr_accessor_set :times_called, ->{ 0 }

    def register_call
      self.times_called += 1
    end

    def delete_caller_from hash
      hash.delete hash_out_caller if internal_call?
    end

    private

    def internal_call?
      times_called > 1
    end
  end
end
