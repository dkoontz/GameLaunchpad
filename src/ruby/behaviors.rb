require 'inflector'

module GameLaunchpad
  module Behaviors
    def self.included(base)
      base.extend BehaviorClassMethods
      base.send(:include, BehaviorInstanceMethods)
    end
  end

  module BehaviorInstanceMethods
    def initialize_behavior_system
      @__behaviors = {}
    end

    def add_behavior(name)
      require "behaviors/#{name.underscore}" unless Object.const_defined? name.camelize
      raise "Behavior #{name} has already been added to #{self}" if @__behaviors[name.underscore.to_sym]
      @__behaviors[name.underscore.to_sym] = name.camelize.constantize.new(self)
    end

    def remove_behavior(name)
      raise "Behavior #{name} does not exist on #{self}" unless @__behaviors[name.underscore.to_sym]
      @__behaviors[name.underscore.to_sym].remove
      @__behaviors.delete name.underscore.to_sym
    end

    def has_behavior?(name)
      !@__behaviors[name.underscore.to_sym].nil?
    end
  end

  module BehaviorClassMethods
    
  end
end