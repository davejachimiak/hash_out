module HashOut
  module DelegatorRegistry
    def exclude_delegators_from_hash_out
      @register_delegators = true
    end

    def def_instance_delegator *args
      register_delegator args[-1] if register_delegators?
      super
    end
    alias def_delegator def_instance_delegator

    def delegators
      @delegators ||= []
    end

    private

    def register_delegator delegator
      delegators.push delegator
    end

    def register_delegators?
      !!@register_delegators
    end
  end
end
