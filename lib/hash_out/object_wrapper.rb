module HashOut
  class ObjectWrapper
    def initialize object
      @object = object
    end

    def duplication
      @duplication ||= @object.dup
    end

    def public_methods_requiring_no_args
      @object.public_methods(false).select do |m|
        [-1, 0].include? @object.method(m).arity
      end
    end

    def method_value_pair method
      [method, @object.send(method)]
    end
  end
end
