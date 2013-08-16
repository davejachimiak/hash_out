module InitAttrs
  module ClassMethods
    def init_accessor name, procedure=nil, &block
      register_attr name, procedure || block
      attr_accessor name
    end

    def init_reader name, procedure=nil, &block
      register_attr name, procedure || block
      attr_reader name
    end

    def new *args
      @instance = super
      set_ivars
      @instance
    end

    private

    def register_attr name, procedure
      attrs.merge! "#{name}" => procedure
    end

    def attrs
      @attrs ||= {}
    end

    def set_ivars
      attrs.each_pair do |name, procedure|
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
