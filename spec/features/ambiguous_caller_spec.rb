require_relative '../spec_helper'

describe 'ambiguous caller' do
  class What
    include HashOut

    def huh
      :yep
    end
  end

  class Yep
    def self.huh
      What.new.hash_out
    end
  end

  it "keeps the key of the name of another object's caller" do
    hash_out = { huh: :yep }
    expect(Yep.huh).to_equal hash_out
  end
end
