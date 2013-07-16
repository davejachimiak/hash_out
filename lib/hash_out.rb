require 'hash_out/hasher'

module HashOut
  def hash_out
    hash_out_caller = _caller_method_sym caller.first
    _hasher(hash_out_caller).object_to_hash
  end

  protected

  def exclude_from_hash_out
    excluded_method = _caller_method_sym caller.first
    _exclusions.add excluded_method
  end

  private

  def _caller_method_sym caller_string
    caller_string.match(/`(.*)'/)[1].to_sym
  end

  def _exclusions
    _hasher.exclusions
  end

  def _hasher hash_out_caller=nil
    @_hasher ||= Hasher.new self, hash_out_caller
  end
end
