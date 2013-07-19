require 'last_call'
require 'hash_out/hasher'
require 'hash_out/call_registry'
require 'hash_out/object_wrapper'

module HashOut
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
