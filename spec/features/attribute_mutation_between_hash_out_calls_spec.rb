require_relative '../spec_helper'

describe 'attribute mutation between #hash_out calls' do
  class Ooze
    include HashOut
    attr_accessor :color
  end

  it 'accounts for it between calls to #hash_out' do
    ooze = Ooze.new
    ooze.color = :green
    expect(ooze.hash_out).to_equal({color: :green})

    ooze.color = :purple
    expect(ooze.hash_out).to_equal({color: :purple})
  end
end
