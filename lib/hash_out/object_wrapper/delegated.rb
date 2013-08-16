require 'hash_out/delegator_excludable'

module HashOut
  class ObjectWrapper
    class Delegated < ObjectWrapper
      memoize_reader :excludable, ->{ dup.extend DelegatorExcludable }
    end
  end
end
