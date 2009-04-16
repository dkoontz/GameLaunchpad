module GameLaunchpad
  class DefaultRenderManager < Manager
    def render(graphics)
      @scene.manager(:game_object).each do |object|
        object.render(graphics)
      end
    end
  end
end