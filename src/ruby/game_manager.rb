module GameLaunchpad
  class GameManager < Java::com::gamedevgarden::GameManagerBase
    def initialize(container, scene)
      super()
      @container = container
      @scene = load_scene(scene)
    end

    def load_scene(scene)
      begin
        require "src/scenes/#{scene.underscore}" unless Object.const_defined? scene.camelize
        scene.camelize.constantize.new(@container)
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