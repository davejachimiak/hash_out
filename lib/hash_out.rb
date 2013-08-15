require 'last_call'
require 'hash_out/hasher'
require 'hash_out/call_registry'
require 'hash_out/object_wrapper'

module HashOut
  include LastCall

  module DelegatorRegistry
    def exclude_delegators_from_hash_out
      @register_delegators = true
    end

    def def_instance_delegator *args
      register_delegator *args[-1] if register_delegators?
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

  def self.included base
    if base.respond_to? :delegate
      base.extend DelegatorRegistry
    end
  end

  def hash_out
    _register_call last_call
    _hasher.object_to_hash
  end

  private

  def _register_call hash_out_caller
    _call_registry(hash_out_caller).register_call
  end

  def _call_registry hash_out_caller=nil
    @_call_registry ||= CallRegistry.new hash_out_caller
  end

  def _hasher
    @_hasher ||= Hasher.new _wrapped_self, _call_registry
  end

  def _wrapped_self
    @_wrapped_self ||= ObjectWrapper.new self
  end

  def exclude_from_hash_out; end;
end
