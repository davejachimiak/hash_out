require 'hash_out/delegator_excludable'

module HashOut
  class ObjectWrapper
    class Delegated < ObjectWrapper
      init_reader :excludable, ->{ dup.extend DelegatorExcludable }
    end
  end
end
