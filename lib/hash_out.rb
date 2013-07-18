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
    object_wrapper ||= ObjectWrapper.new self
    @_hasher ||= Hasher.new object_wrapper, _call_registry
  end

  def _methods_requiring_no_args
    public_methods(false).select { |m| [-1, 0].include? method(m).arity }
  end

  def _method_value_pair method
    [method, send(method)]
  end

  def exclude_from_hash_out; end;
end
