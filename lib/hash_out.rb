module HashOut
  require 'set'

  def hash_out
    set_hash_out
    delete_exclusions
    @hash_out
  end

  protected

  def exclude_from_hash_out
    excluded_method = caller_method_sym caller.first
    exclusions.add excluded_method
  end

  private

  def set_hash_out
    @hash_out = Hash[public_methods_and_values]
  end

  def public_methods_and_values
    public_method_names.map { |method_name| name_value_pair method_name }
  end

  def public_method_names
    public_methods false
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
