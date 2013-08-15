require_relative '../spec_helper'

describe 'compatibility with delegators' do
  require 'forwardable'

  class Clarissa
    extend Forwardable
    include HashOut

    exclude_delegators_from_hash_out

    def_delegator  :@cool, :upcase
    def_delegator  :@guys, :downcase, :lowercase_guys
    def_delegators :@alright, :to_s

    def initialize
      @cool    = 'cool'
      @guys    = 'GUYS'
      @alright = :alright
    end

    def hey
      upcase
    end

    def sup
      lowercase_guys
    end

    def alright
      to_s
    end
  end

  it 'is ignores methods written by Forwardable' do
    clarissa = Clarissa.new
    hash_out = { hey: 'COOL', sup: 'guys', alright: 'alright' }

    expect(clarissa.hash_out).to_equal hash_out
  end
end
