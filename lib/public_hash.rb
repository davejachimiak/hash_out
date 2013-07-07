module PublicHash
  def public_hash
    Hash[*alternating_method_names_and_values]
  end

  private

  def alternating_method_names_and_values
    method_names.map do |method_name|
      [method_name, send(method_name)]
    end.flatten
  end

  def method_names
    public_methods false
  end
end

require 'minitest/autorun'
require 'minitest/spec/expect'

describe 'integration' do
  describe '#public_hash' do
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
  end
end
