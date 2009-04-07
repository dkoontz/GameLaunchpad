class RubyGame < Java::com::gamegarden::RubyGame
#  include Java::com::gamegarden::RubyGame
  
  def initialize
#    @game_id = game_id
    puts "in RubyGame initialize"
  end

  def update(container, delta)
    
  end

  def render(container, graphics)
    graphics.draw_string("hello from pure-Ruby!", 10, 35)
  end
end