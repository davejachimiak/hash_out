require 'hash_out/excludable'
require 'forwardable'

module HashOut
  class Hasher < Struct.new :object, :call_registry
    extend Forwardable

    def_delegator :object, :duplication, :obj_dup

    def object_to_hash
      prepare_hashable_methods
      delete_excluded_methods
      Hash[hashable_method_value_pairs]
    end

    private

    def prepare_hashable_methods
      @hashable_methods = object.public_methods_requiring_no_args
      call_registry.delete_caller_from @hashable_methods
    end

    def delete_excluded_methods
      obj_dup.extend Excludable
      obj_dup.prepare_exclusions @hashable_methods
      obj_dup.delete_exclusions @hashable_methods
    end

    def hashable_method_value_pairs
      @hashable_methods.map do |method|
        object.method_value_pair method
      end
    end
  end
end
