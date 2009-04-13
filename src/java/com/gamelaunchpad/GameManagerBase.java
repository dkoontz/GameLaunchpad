package com.gamelaunchpad;

import org.newdawn.slick.GameContainer;
import org.newdawn.slick.Graphics;

public abstract class GameManagerBase
{
  abstract public void update( GameContainer container, int delta );
  abstract public void render( GameContainer container, Graphics g );
}