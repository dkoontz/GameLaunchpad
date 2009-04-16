require 'game_object'
require 'manager'
require 'inflector'
require 'scenes/base_scene'

module GameLaunchpad
  class GameManager < Java::com::gamelaunchpad::GameManagerBase
    def initialize(container, scene)
      super()
      @container = container
      @scene = load_scene(scene)
    end

    def load_scene(scene)
      begin
        unless Object.const_defined? scene.camelize
          require "scenes/#{scene.underscore}"
          scene.camelize.constantize.new(@container)
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