require 'set'

module HashOut
  class Hasher < Struct.new :object, :hash_out_caller
    def object_to_hash
      set_hashable_methods
      set_hash
      delete_exclusions
      @hash
    end

    def exclusions
      @exclusions ||= Set.new
    end

    private

    def set_hash
      @hash = Hash[hashable_methods_and_values]
    end

    def hashable_methods_and_values
      @hashable_methods.map { |method_name| name_value_pair method_name }
    end

    def set_hashable_methods
      @hashable_methods = object.public_methods(false).select do |method|
        does_not_require_arg? method
      end

      @hashable_methods.delete hash_out_caller
    end

    def does_not_require_arg? method
      [-1, 0].include? object.method(method).arity
    end

    def name_value_pair method_name
      [method_name, object.send(method_name)]
    end

    def delete_exclusions
      exclusions.each { |exclusion| @hash.delete exclusion }
    end
  end
end
