require 'set'

module HashOut
  class Hasher < Struct.new :object, :call_registry
    def object_to_hash
      prepare_hashable_methods
      set_hash
      @hash
    end

    def exclusions
      @exclusions ||= Set.new
    end

    def exclude method
      exclusions.add method
    end

    private

    def prepare_hashable_methods
      @hashable_methods = object.send :_methods_requiring_no_args
      call_registry.delete_caller_from @hashable_methods
      @hashable_methods.reject! do |method|
        dup_obj = object.dup
        dup_obj.send method
        dup_obj.send :_excluded?, method
      end
    end

    def set_hash
      @hash = Hash[hashable_method_value_pairs]
    end

    def hashable_method_value_pairs
      @hashable_methods.map do |method|
        object.send :_method_value_pair, method
      end
    end
  end
end
