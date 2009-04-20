module GameLaunchpad
  class DefaultRenderManager < Manager

    def load
      @renderable_game_objects = []
      @scene.manager(:game_object).after_game_object_added do |object|
        @renderable_game_objects << object if object.responds_to? :render
      end

      @scene.manager(:game_object).after_game_object_removed do |object|
        @renderable_game_objects.delete object
      end
    end

    def render(graphics)
      @renderable_game_objects.each do |object|
        begin
          object.render(graphics)
        rescue NameError => e
          @renderable_game_objects.delete object if e.message =~ /^undefined local variable or method `render'/
          next
        end
      end
    end
  end
end