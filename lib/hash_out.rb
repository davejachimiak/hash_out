require 'last_call'
require 'hash_out/hasher'

module HashOut
  def hash_out
    _hasher(last_call).object_to_hash
  end

  protected

  def exclude_from_hash_out
    _exclusions.add last_call
  end

  private

  def _exclusions
    _hasher.exclusions
  end

  def _hasher hash_out_caller=nil
    @_hasher ||= Hasher.new self, hash_out_caller
  end
end
