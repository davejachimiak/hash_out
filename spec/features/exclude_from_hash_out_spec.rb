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

  class Lips
    include HashOut

    def initialize
      @size = :small
    end

    def botox
      exclude_from_hash_out
      @size = :fat
    end

    def size
      @size
    end
  end

  it 'blocks mutation effects below call' do
    lips     = Lips.new
    hash_out = { size: :small }

    expect(lips.hash_out).to_equal hash_out
  end

  it 'mutates if call is not from #hash_out' do
    lips = Lips.new
    lips.botox
    expect(lips.size).to_equal :fat
  end
end
