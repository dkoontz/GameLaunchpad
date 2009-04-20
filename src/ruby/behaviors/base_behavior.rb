require 'set'
require 'callbacks'

class BaseBehavior
  include GameLaunchpad::Callbacks


  def initialize(target)
    @target = target
    @declared_methods = Set.new
  end

  def remove
    # Remove all declared methods from target object
    raise "Not yet implemented"
  end

  def declare_methods(*names)
    names.each do |name|
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
      @target.send(:eval, <<-ENDL
                            def #{name}(#{argument_string})
                              @behaviors[#{self.class.name.underscore}].#{name}(#{argument_string})
                            end
                          ENDL
                  )
    end
  end
end