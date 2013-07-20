require_relative '../spec_helper'

describe 'compatibility with delegators' do
  require 'forwardable'

  class Clarissa
    include HashOut
    extend Forwardable

    def_delegator :@cool, :upcase

    def initialize
      @cool = 'cool'
    end

    def hey
      upcase
    end
  end

  it 'is ignores methods written by Forwardable' do
    clarissa = Clarissa.new
    hash_out = { cool: 'Cool' }

    # expect(clarissa.hash_out).to_equal hash_out
  end
end
