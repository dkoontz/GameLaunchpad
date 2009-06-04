# Copyright (c) 2009 GameLaunchpad
# All rights reserved.

require 'game_object'
require 'manager'
require 'inflector'
require 'behaviors/base_behavior'
require 'scenes/base_scene'
require 'logger'

module GameLaunchpad
  class GameManager < Java::com::gamelaunchpad::GameManagerBase
    
    # Global "heartbeat" of the game.  All behaviors needing to detect the passage
    # of time should query this method to allow the game to be paused.
    def self.current_time
      java.lang.System.current_time_millis
    end

    def self.logger
      if !class_variable_defined?(:@@logger)
        @@logger = Logger.new('gamelaunchpad.log', 10, 1024000 * 10)
        @@logger.level = Logger::WARN
      end

      @@logger
    end

    def initialize(container, scene)
      super()
      puts "in game manager initialize"
      @container = container
      # Scene system should be re-done to use Slick's state class
      @scene = load_scene(scene)
    end

    def load_scene(scene)
      begin
        unless Object.const_defined? scene.camelize
          require "scenes/#{scene.underscore}"
          scene.camelize.constantize.new(self, @container)
        end
      rescue LoadError => e
        raise ArgumentError, "Invalid scene name #{scene.inspect}\nOriginal error: #{e.message}\n#{e.backtrace}"
      end
    end

    def update(container, delta)
      @container.input.poll(@container.width, @container.height)
      @scene.input_manager.update(delta)
      @scene.update_manager.update(delta)
    end

    def render(container, graphics)
      @scene.render_manager.render(graphics)
    end
  end
end