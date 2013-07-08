module PublicHash
  def public_hash
    @public_hash || determine_public_hash
  end

  private

  def determine_public_hash
    @exclusions  = []
    @public_hash = delete_exclusions Hash[public_methods_and_values]
  end

  def public_methods_and_values
    public_method_names.map { |method_name| name_value_pair method_name  }
  end

  def name_value_pair method_name
    [method_name, send(method_name)]
  end

  def public_method_names
    public_methods false
  end

  def delete_exclusions hash
    @exclusions.each { |exclusion| hash.delete exclusion }
    hash
  end

  def exclude_from_public_hash
    excluded_method = caller_method_sym caller.first
    @exclusions.push excluded_method
  end

  def caller_method_sym caller_string
    caller_string.match(/`(.*)'/)[1].to_sym
  end
end

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
