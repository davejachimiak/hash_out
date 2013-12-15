require 'hash_out/excludable'

module HashOut
  class Hasher < Struct.new :object, :call_registry
    extend  Forwardable
    include InitAttrs

    def_delegator :object, :excludable, :excludable_object
    init_accessor :hashable_methods do
      object.public_methods_requiring_no_args
    end

    def object_to_hash
      prepare_hashable_methods
      Hash[hashable_method_value_pairs]
    end

    private

    def prepare_hashable_methods
      call_registry.delete_caller_from hashable_methods
      excludable_object.exclude_exclusions_from hashable_methods
    end

    def hashable_method_value_pairs
      hashable_methods.map { |method| object.method_value_pair method }
    end
  end
end
