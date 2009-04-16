include_class "org.newdawn.slick.TrueTypeFont"
include_class "java.awt.Font"

class Text < GameLaunchpad::GameObject
  PLAIN = Font::PLAIN
  ITALIC = Font::ITALIC
  BOLD = Font::BOLD

  def initialize(text, x, y)
    @x = x
    @y = y
    @text = text
    load_font("Arial", PLAIN, 12)
  end

  def render(graphics)
    @font.draw_string(@x, @y, @text)
  end

private
  def load_font(font_name, style, size)
    @font = TrueTypeFont.new(Font.new(font_name, style, size), true)
  end
end