require_relative '../../lib/hash_out'
require 'minitest/autorun'
require 'minitest/spec/expect'

describe 'HashOut#hash_out' do
  class Baller
    include HashOut

    def mood
      :ballin
    end

    def height
      :tall
    end
  end

  it 'returns a hash of name-values' do
    baller   = Baller.new
    hash_out = {
      mood:   baller.mood,
      height: baller.height
    }

    expect(baller.hash_out).to_equal hash_out
  end

  class ShotCaller
    include HashOut

    def front
      :chillin
    end

    private

    def real_mood
      :nervous
    end
  end

  it 'ignores private methods' do
    shot_caller = ShotCaller.new
    hash_out    = { front: shot_caller.front }

    expect(shot_caller.hash_out).to_equal hash_out
  end

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

  class Beans; end;
  class Grinder
    include HashOut

    def initialize
      @beans = Beans.new
    end

    def grind settings, beans=@beans
      with_settings(settings) do |grinder|
        beans.krush_with grinder
      end
    end

    def clean materials
      clean_with materials
      @cleaned = true
    end

    def blade edge=:sharp
      edge
    end

    private

    def with_settings settings
      @settings = settings
      yield self
    end

    def clean_with materials
      #
    end
  end

  it 'ignores public methods that require arguments' do
    grinder  = Grinder.new
    hash_out = { blade: grinder.blade }

    expect(grinder.hash_out).to_equal hash_out
  end

  class SoMeta
    include HashOut

    def an_method
      :result
    end

    def attributes
      hash_out
    end
  end

  it "ignores internal public method that calls #hash_out" do
    so_meta  = SoMeta.new
    hash_out = { an_method: :result }

    expect(so_meta.attributes).to_equal hash_out
  end
end
