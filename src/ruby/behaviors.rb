require 'inflector'

module GameLaunchpad
  module Behaviors
    def self.included(base)
      base.extend ClassMethods
      base.send(:include, InstanceMethods)
    end
  end

  module InstanceMethods
    def initialize_behavior_system
      @behaviors = {}
    end

    def add_behavior(name)
      require "behaviors/#{name.underscore}" unless Object.const_defined? name.camelize
      raise "Behavior #{name} has already been added to #{self}" if @behaviors[name.underscore.to_sym]
      @behaviors[name.underscore.to_sym] = name.camelize.constantize.new(self)
    end

    def remove_behavior(name)
      raise "Behavior #{name} does not exist on #{self}" unless @behaviors[name.underscore.to_sym]
      @behaviors[name.underscore.to_sym].remove(self)
      @behaviors.delete name.underscore.to_sym
    end
  end

  module ClassMethods
    
  end
end