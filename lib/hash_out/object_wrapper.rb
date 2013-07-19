require 'hash_out/excludable'
require 'forwardable'

module HashOut
  class ObjectWrapper < Struct.new :object
    extend Forwardable

    def_delegators :object, :dup, :public_methods, :send, :method

    def excludable
      @excludable ||= dup.extend Excludable
    end

    def public_methods_requiring_no_args
      public_methods(false).select { |method| requires_no_args? method }
    end

    def method_value_pair method
      [method, send(method)]
    end

    private

    def requires_no_args? m
      [-1, 0].include? method(m).arity
    end
  end
end
