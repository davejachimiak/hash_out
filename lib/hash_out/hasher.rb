require 'set'

module HashOut
  class Hasher < Struct.new :object, :hash_out_caller
    def object_to_hash
      exclusions.add hash_out_caller

      block_recursion do
        set_hash
        delete_exclusions
      end

      @hash
    end

    def exclusions
      @exclusions ||= Set.new
    end

    private

    def block_recursion
      @times_called ||= 0
      @times_called  += 1

      yield if @times_called == 1

      @times_called = 0
    end

    def set_hash
      @hash = Hash[interesting_methods_and_values]
    end

    def interesting_methods_and_values
      methods_requiring_no_arguments.map do |method_name|
        name_value_pair method_name
      end
    end

    def methods_requiring_no_arguments
      object.public_methods(false).select { |m| [-1, 0].include? object.method(m).arity }
    end

    def name_value_pair method_name
      [method_name, object.send(method_name)]
    end

    def delete_exclusions
      exclusions.each { |exclusion| @hash.delete exclusion }
    end
  end
end
