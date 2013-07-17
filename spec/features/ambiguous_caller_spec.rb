require_relative '../spec_helper'

describe 'ambiguous caller' do
  class One
    include HashOut

    def melted_attributes
      true
    end
  end

  class Two
    def melted_attributes
      One.new.hash_out
    end
  end

  it "keeps the key of the name of another object's caller" do
    two      = Two.new
    hash_out = { melted_attributes: true }

    expect(two.melted_attributes).to_equal hash_out
  end
end
