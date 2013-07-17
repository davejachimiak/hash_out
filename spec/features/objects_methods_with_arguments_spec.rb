require_relative '../spec_helper'

describe "object's methods with arguments" do
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
    end
  end

  it 'ignores public methods that require arguments' do
    grinder  = Grinder.new
    hash_out = { blade: grinder.blade }

    expect(grinder.hash_out).to_equal hash_out
  end
end
