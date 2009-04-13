require 'scenes/base_scene'
require 'inflector'

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
          # Try loading GameLaunchpad.jar scenes first, then the scenes from the application's jar.
          begin
            require "scenes/#{scene.underscore}"
          rescue LoadError
            require "src/scenes/#{scene.underscore}"
          end
          scene.camelize.constantize.new(@container)
        end
      rescue => e
        raise ArgumentError, "Invalid scene name #{scene.inspect}\nOriginal error: #{e.message}\n#{e.backtrace}"
      end
    end

    def update(container, delta)
      @scene.manager(:input).update(delta)
      @scene.manager(:update).update(delta)
    end

    def render(container, graphics)
      @scene.manager(:render).render(graphics)
      #      graphics.draw_string("Rendering", 10, 35)
    end
  end
end