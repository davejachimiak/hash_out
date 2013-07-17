require 'set'

module HashOut
  class Hasher < Struct.new :object, :hash_out_caller
    def object_to_hash
      set_hash
      delete_exclusions
      @hash
    end

    def exclusions
      @exclusions ||= Set.new
    end

    private

    def set_hash
      @hash = Hash[interesting_methods_and_values]
    end

    def interesting_methods_and_values
      methods_requiring_no_arguments.map do |method_name|
        name_value_pair method_name
      end
    end

    def methods_requiring_no_arguments
      object.public_methods(false).select do |m|
        [-1, 0].include? object.method(m).arity
      end.reject { |m| m == hash_out_caller }
    end

    def name_value_pair method_name
      [method_name, object.send(method_name)]
    end

    def delete_exclusions
      exclusions.each { |exclusion| @hash.delete exclusion }
    end
  end
end
