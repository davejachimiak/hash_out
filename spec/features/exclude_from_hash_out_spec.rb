require_relative '../spec_helper'

describe '#exclude_from_hash_out' do
  class Brawler
    include HashOut

    def fighting?
      true
    end

    def pancakes
      exclude_from_hash_out
      'yes please'
    end
  end

  it 'ignores public methods that declare exclusion from public hash' do
    brawler  = Brawler.new
    hash_out = { fighting?: brawler.fighting? }

    expect(brawler.hash_out).to_equal hash_out
  end

  class Surgery
    include HashOut

    def initialize
      @lips = :small
    end

    def botox
      exclude_from_hash_out
      @lips = :fat
    end

    def lips
      @lips
    end
  end

  it 'blocks mutation effects below call' do
    surgery  = Surgery.new
    hash_out = { lips: :small }

    expect(surgery.hash_out).to_equal hash_out
  end
end
