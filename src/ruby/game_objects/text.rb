# Copyright (c) 2009 GameLaunchpad
# All rights reserved.

include_class "org.newdawn.slick.TrueTypeFont"
include_class "java.awt.Font"

class Text < GameLaunchpad::GameObject
  PLAIN = Font::PLAIN
  ITALIC = Font::ITALIC
  BOLD = Font::BOLD
  STYLES = [PLAIN, ITALIC, BOLD]

  attr_accessor :text

  def load(text, x, y, font_name = "Arial", style = PLAIN, font_size = 12)
    add_behavior :spatial

    self.x.value = x
    self.y.value = y
    @text = text
    change_font(font_name, style, font_size)
  end

  def change_font(font_name, style, size)
    raise "Invalid font style #{style}" unless STYLES.member? style
    @font = TrueTypeFont.new(Font.new(font_name, style, size), true)
  end

  def render(graphics)
    @font.draw_string(x.value, y.value, @text)
  end

end