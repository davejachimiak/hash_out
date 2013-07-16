require 'set'

module HashOut
  def hash_out
    hash_out_caller = _caller_method_sym caller.first
    hash            = _hasher(hash_out_caller).object_to_hash

    _uncache_hasher
    hash
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

  def _uncache_hasher
    @_hasher = nil
  end

  def _hasher hash_out_caller=nil
    @_hasher ||= Hasher.new self, hash_out_caller
  end

  class Hasher < Struct.new :object, :hash_out_caller
    def object_to_hash
      exclusions.add hash_out_caller

      block_recursion do
        set_hash_out
        delete_exclusions
      end

      @hash
    end

    def exclusions
      @exclusions ||= Set.new
    end

    private

    def block_recursion
      @times_called ||= 0
      @times_called  += 1

      if @times_called == 1
        yield
      else
        return
      end

      @times_called = 0
    end

    def set_hash_out
      @hash = Hash[interesting_methods_and_values]
    end

    def interesting_methods_and_values
      methods_requiring_no_arguments.map do |method_name|
        name_value_pair method_name
      end
    end

    def methods_requiring_no_arguments
      object.public_methods(false).select { |m| [-1, 0].include? object.method(m).arity }
    end

    def name_value_pair method_name
      [method_name, object.send(method_name)]
    end

    def delete_exclusions
      exclusions.each { |exclusion| @hash.delete exclusion }
    end
  end
end
