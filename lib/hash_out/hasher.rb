require 'set'
require 'hash_out/excluder'

module HashOut
  class Hasher < Struct.new :object, :call_registry
    def object_to_hash
      prepare_hashable_methods
      reject_excluded_methods
      Hash[hashable_method_value_pairs]
    end

    private

    def prepare_hashable_methods
      @hashable_methods = object.send :_methods_requiring_no_args
      call_registry.delete_caller_from @hashable_methods
    end

    def reject_excluded_methods
      (dup_obj = object.dup).extend Excludable
      dup_obj.prepare_exclusions @hashable_methods
      dup_obj.delete_exclusions @hashable_methods
    end

    def hashable_method_value_pairs
      @hashable_methods.map do |method|
        object.send :_method_value_pair, method
      end
    end
  end
end
