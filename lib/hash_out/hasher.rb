require 'set'

module HashOut
  class Hasher < Struct.new :object, :call_registry
    def object_to_hash
      prepare_hashable_methods
      set_hash
      delete_exclusions
      @hash
    end

    def exclusions
      @exclusions ||= Set.new
    end

    private

    def prepare_hashable_methods
      @hashable_methods = object.send :_methods_requiring_no_args
      call_registry.delete_caller @hashable_methods
    end

    def set_hash
      @hash = Hash[hashable_methods_and_values]
    end

    def hashable_methods_and_values
      @hashable_methods.map { |method_name| name_value_pair method_name }
    end

    def name_value_pair method_name
      [method_name, object.send(method_name)]
    end

    def delete_exclusions
      exclusions.each { |exclusion| @hash.delete exclusion }
    end
  end
end
