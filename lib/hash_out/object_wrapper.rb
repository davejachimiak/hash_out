require 'hash_out/excludable'

module HashOut
  class ObjectWrapper
    def initialize object
      @object = object
    end

    def excludable
      @excludable ||= begin
                        dup_obj = @object.dup
                        dup_obj.extend Excludable
                        dup_obj
                      end
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
