require_relative '../spec_helper'

describe 'compatibility with delegators' do
  require 'forwardable'

  class FreshPrince
    extend  Forwardable
    include HashOut

    def_delegator :@aww, :to_sym, :aww

    def initialize
      @aww = 'yeah'
    end
  end

  it 'it keeps methods written by Forwardable if delegators are not excluded' do
    fresh_prince = FreshPrince.new
    hash_out     = { aww: :yeah }

    expect(fresh_prince.hash_out).to_equal hash_out
  end

  class Clarissa
    extend  Forwardable
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

  it 'is ignores methods written by Forwardable if delegators are excluded' do
    clarissa = Clarissa.new
    hash_out = { hey: 'COOL', sup: 'guys', alright: 'alright' }

    expect(clarissa.hash_out).to_equal hash_out
  end
end
