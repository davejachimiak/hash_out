module InitAttrs
  module ClassMethods
    def init_accessor name, procedure=nil, &block
      _register_attr_with_type :attr_accessor, name, procedure || block
    end

    def init_reader name, procedure=nil, &block
      _register_attr_with_type :attr_reader, name, procedure || block
    end

    def new *args
      instance = super
      _set_ivars instance
      instance
    end

    def _register_attr_with_type type, name, procedure
      _register_attr name, procedure
      send type, name
    end

    private

    def _register_attr name, procedure
      _attrs.merge! "#{name}" => procedure
    end

    def _attrs
      @_attrs ||= {}
    end

    def _set_ivars instance
      _attrs.each_pair do |name, procedure|
        instance.instance_variable_set "@#{name}", value(instance, procedure)
      end
    end

    def value instance, procedure
      instance.instance_exec &procedure
    end
  end

  def self.included base
    base.extend ClassMethods
  end
end
