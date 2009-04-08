class GameManager < Java::com::gamedevgarden::RubyGame
#  include Java::com::gamegarden::RubyGame
  
  def initialize(game_id)
    super()
    @game_id = game_id
    puts "in RubyGame initialize, loading game_id #{game_id}"

  end

  def update(container, delta)
    
  end

  def render(container, graphics)
    
  end
end