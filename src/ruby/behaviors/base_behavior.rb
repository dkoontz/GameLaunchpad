require 'set'
require 'callbacks'
require 'property'

module GameLaunchpad
  class BaseBehavior
    include GameLaunchpad::Callbacks
    include GameLaunchpad::Properties

    def initialize(target)
      @target = target
      @declared_methods = Set.new
      load
    end

    def load

    end

    def remove
      @declared_methods.each do |method|
        singleton_class = class <<@target; self; end
        begin
          singleton_class.send :remove_method, method
        rescue NameError
          # If the method we're trying to remove is already
          # gone, just continue on
        end
      end
    end

    def declare_methods(*names)
      names.each do |name|
        raise "Method #{name} already exists on object #{@target}, cannot add method from behavior #{self.class}" if @target.methods.member? name.to_s

        @declared_methods << name.to_sym
        # Add all declared methods to target object

        method_arity = method(name).arity
        argument_string = case method_arity
        when -1
          "*arguments, &block"
        when 0
          "&block"
        when 1..26
          ('a'..'z').to_a[0...method_arity].join(", ") + ", &block"
        else
          raise "Unknown arity #{method_arity} for method #{name} in behavior #{self.class}"
        end
        @target.send :instance_eval, <<-ENDL
           def #{name}(#{argument_string})
             @__behaviors[:#{self.class.name.underscore}].#{name}(#{argument_string})
           end
           ENDL
      end
    end
  end
end