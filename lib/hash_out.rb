module HashOut
  require 'set'

  def hash_out
    caller_method = caller_method_sym caller.first

    handle_recursion(caller_method) do
      if @called == 1
        set_hash_out
        delete_exclusions
      end
    end

    @hash_out
  end

  protected

  def exclude_from_hash_out
    excluded_method = caller_method_sym caller.first
    exclusions.add excluded_method
  end

  private

  def handle_recursion hash_out_caller
    @called ||= 0
    @called  += 1
    exclusions.add hash_out_caller
    yield
    @called = 0
  end

  def set_hash_out
    @hash_out = Hash[interesting_methods_and_values]
  end

  def interesting_methods_and_values
    methods_requiring_no_arguments.map do |method_name|
      name_value_pair method_name
    end
  end

  def methods_requiring_no_arguments
    public_methods(false).select { |m| [-1, 0].include? method(m).arity }
  end

  def name_value_pair method_name
    [method_name, send(method_name)]
  end

  def delete_exclusions
    exclusions.each { |exclusion| @hash_out.delete exclusion }
  end

  def exclusions
    @exclusions ||= Set.new
  end

  def caller_method_sym caller_string
    caller_string.match(/`(.*)'/)[1].to_sym
  end
end
