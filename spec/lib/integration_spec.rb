require_relative '../../lib/public_hash'
require 'minitest/autorun'
require 'minitest/spec/expect'

describe 'PublicHash#public_hash' do
  class Baller
    include PublicHash

    def mood
      :ballin
    end

    def height
      :tall
    end
  end

  it 'returns a hash of name-values' do
    baller      = Baller.new
    public_hash = {
      mood:   baller.mood,
      height: baller.height
    }

    expect(baller.public_hash).to_equal public_hash
  end

  class ShotCaller
    include PublicHash

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
    public_hash = { front: shot_caller.front }

    expect(shot_caller.public_hash).to_equal public_hash
  end

  class Brawler
    include PublicHash

    def fighting?
      true
    end

    def pancakes
      exclude_from_public_hash
      'sure'
    end
  end

  it 'ignores public methods that declare exclusion from public hash' do
    brawler      = Brawler.new
    public_hash = { fighting?: brawler.fighting? }

    expect(brawler.public_hash).to_equal public_hash
  end
end
