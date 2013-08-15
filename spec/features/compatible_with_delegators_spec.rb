require_relative '../spec_helper'

describe 'compatibility with delegators' do
  require 'forwardable'

  class Clarissa
    extend Forwardable
    include HashOut

    def_delegator  :@cool, :upcase
    def_delegator  :@guys, :downcase, :lowercase_guys
    def_delegators :@nerd, :to_i, :to_s

    def initialize
      @cool = 'cool'
      @guys = 'GUYS'
      @nerd = '1'
    end

    def hey
      upcase
    end

    def sup
      lowercase_guys
    end

    def one
      to_i
    end
  end

  it 'is ignores methods written by Forwardable' do
    clarissa = Clarissa.new
    hash_out = { hey: 'COOL', sup: 'guys', one: 1 }

    expect(clarissa.hash_out).to_equal hash_out
  end
end
