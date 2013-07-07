require 'minitest/autorun'
require 'minitest/spec/expect'

describe 'integration' do
  it 'adds a #public_hash method to the class that returns a hash of name-values' do
    public_hash = { first_method: 1, second_method: 2 }

    an_object = AnClass.new

    expect(an_object.public_hash).to_equal public_hash
  end
end

