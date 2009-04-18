require 'game_object'
require 'manager'
require 'inflector'
require 'scenes/base_scene'

module GameLaunchpad
  class GameManager < Java::com::gamelaunchpad::GameManagerBase
    
    # Global "heartbeat" of the game.  All behaviors needing to detect the passage
    # of time should query this method to allow the game to be paused.
    def self.current_time
      java.lang.System.current_time_millis
    end

    def initialize(container, scene)
      super()
      @container = container
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
      @scene.manager(:input).update(delta)
      @scene.manager(:update).update(delta)
    end

    def render(container, graphics)
      @scene.manager(:render).render(graphics)
    end
  end
end