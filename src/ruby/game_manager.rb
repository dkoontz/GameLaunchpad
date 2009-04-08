class GameManager < Java::com::gamedevgarden::GameManagerBase
  def initialize(container, state)
    super()
    puts "Initializing game manager with state: #{state}"
    @container = container
  end

  def setupGame(container, state)
#    puts "initializing game manager"
#    @container = container
    
  end

  def load_default_scene

  end
  
  def update(container, delta)
    
  end

  def render(container, graphics)
    graphics.draw_string("Rendering", 10, 35)
  end
end