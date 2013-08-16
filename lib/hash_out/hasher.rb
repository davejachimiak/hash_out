require 'hash_out/excludable'
require 'attr_setter'

module HashOut
  class Hasher < Struct.new :object, :call_registry
    extend Forwardable
    include AttrSetter

    def_delegator :object, :excludable, :excludable_object
    attr_accessor_set :hashable_methods do
      object.public_methods_requiring_no_args
    end

    def object_to_hash
      prepare_hashable_methods
      Hash[hashable_method_value_pairs]
    end

    private

    def prepare_hashable_methods
      methods = hashable_methods

      call_registry.delete_caller_from methods
      excludable_object.exclude_exclusions_from methods
    end

    def hashable_method_value_pairs
      hashable_methods.map do |method|
        object.method_value_pair method
      end
    end
  end
end
