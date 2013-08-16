require 'hash_out/excludable'

module HashOut
  class ObjectWrapper < Struct.new :object
    include InitAttrs
    extend  Forwardable

    def_delegators :object, :dup, :public_methods, :send, :method
    init_reader :excludable, ->{ dup.extend Excludable }

    def public_methods_requiring_no_args
      public_methods(false).select { |method| requires_no_args? method }
    end

    def method_value_pair method
      [method, send(method)]
    end

    private

    def requires_no_args? method
      [-1, 0].include? method(method).arity
    end
  end
end
