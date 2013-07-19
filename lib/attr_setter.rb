module AttrSetter
  module ClassMethods
    def attr_accessor_set name, procedure=nil, &block
      register_attr_accessor_set name, procedure || block
      attr_accessor name
    end

    def memoize_reader name, procedure=nil, &block
      register_memoize_reader name, procedure || block
      attr_reader name
    end

    def new *args
      @instance = super *args
      set_accessors
      set_memoized_readers
      @instance
    end

    private

    def register_attr_accessor_set name, procedure
      attr_accessors.merge! "#{name}" => procedure
    end

    def register_memoize_reader name, procedure
      memoized_readers.merge! "#{name}" => procedure
    end

    def attr_accessors
      @attr_accessors ||= {}
    end

    def memoized_readers
      @memoized_readers ||= {}
    end

    def set_accessors
      attr_accessors.each_pair do |name, procedure|
        @instance.instance_variable_set "@#{name}", value(procedure)
      end
    end

    def set_memoized_readers
      memoized_readers.each_pair do |name, procedure|
        @instance.instance_variable_set "@#{name}", value(procedure)
      end
    end

    def value procedure
      @instance.instance_exec &procedure
    end
  end

  def self.included base
    base.extend ClassMethods
  end
end
