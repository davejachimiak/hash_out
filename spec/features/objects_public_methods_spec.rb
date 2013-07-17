require_relative '../spec_helper'

describe "object's public methods" do
  class Baller
    include HashOut

    def mood
      :ballin
    end

    def height
      :tall
    end
  end

  it 'returns a hash of name-values from them' do
    baller   = Baller.new
    hash_out = {
      mood:   baller.mood,
      height: baller.height
    }

    expect(baller.hash_out).to_equal hash_out
  end
end
