class DefaultRenderManager
  def initialize(scene)
    @scene = scene
  end

  def render(graphics)
    graphics.draw_string("Rendering", 10, 35)
  end
end