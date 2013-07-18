require 'hash_out/excludable'

module HashOut
  class ObjectWrapper < Struct.new :object
    def excludable
      @excludable ||= duplicated_object.extend Excludable
    end

    def public_methods_requiring_no_args
      object.public_methods(false).select do |method|
        requires_no_args? method
      end
    end

    def method_value_pair method
      [method, object.send(method)]
    end

    private

    def duplicated_object
      object.dup
    end

    def requires_no_args? method
      [-1, 0].include? object.method(method).arity
    end
  end
end
