require_relative '../spec_helper'

describe "object's private methods" do
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

  it 'ignores them' do
    shot_caller = ShotCaller.new
    hash_out    = { front: shot_caller.front }

    expect(shot_caller.hash_out).to_equal hash_out
  end
end
