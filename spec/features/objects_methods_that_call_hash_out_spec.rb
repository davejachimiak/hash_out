require_relative '../spec_helper'

describe "object's methods that call #hash_out" do
  class SoMeta
    include HashOut

    def an_method
      :result
    end

    def attributes
      hash_out
      hash_out
      hash_out
    end
  end

  it 'ignores internal public method that calls #hash_out any number of times' do
    so_meta  = SoMeta.new
    hash_out = { an_method: :result }

    expect(so_meta.attributes).to_equal hash_out
    expect(so_meta.hash_out).to_equal hash_out
  end
end
