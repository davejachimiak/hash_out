module PublicHash
  def public_hash
    Hash[*alternating_method_names_and_values]
  end

  private

  def alternating_method_names_and_values
    method_names.map do |method_name|
      [method_name, send(method_name)]
    end.flatten
  end

  def method_names
    public_methods false
  end
end

class ClassWithTwoPublicInstanceMethods
  include PublicHash

  def first_method
    1
  end

  def second_method
    'two'
  end
end

require 'minitest/autorun'
require 'minitest/spec/expect'

describe 'integration' do
  it 'adds a #public_hash method to the class that returns a hash of name-values' do
    an_object   = ClassWithTwoPublicInstanceMethods.new
    public_hash = {
      first_method:  an_object.first_method,
      second_method: an_object.second_method
    }

    expect(an_object.public_hash).to_equal public_hash
  end
end
