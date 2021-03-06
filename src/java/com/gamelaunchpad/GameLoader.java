/*
 * Copyright (c) 2009 GameLaunchpad
 * All rights reserved.
 */

package com.gamelaunchpad;

import java.util.ArrayList;
import org.newdawn.slick.BasicGame;
import org.newdawn.slick.GameContainer;
import org.newdawn.slick.Graphics;
import org.newdawn.slick.SlickException;
import org.jruby.Ruby;
import org.jruby.RubyRuntimeAdapter;
import org.jruby.javasupport.JavaEmbedUtils;
import org.jruby.runtime.builtin.IRubyObject;
import org.newdawn.slick.AppGameContainer;
import org.newdawn.slick.AppletGameContainer;

public class GameLoader extends BasicGame
{
  GameManagerBase game;
  Ruby runtime;
  RubyRuntimeAdapter evaler;

  public GameLoader()
  {
    super( "Loading Game..." );
    long start = System.currentTimeMillis();
    runtime = JavaEmbedUtils.initialize(new ArrayList());
    evaler = JavaEmbedUtils.newRuntimeAdapter();
    long stop = System.currentTimeMillis();
    org.newdawn.slick.util.Log.info("Spent " + (stop - start) + " milliseconds loading JRuby");
  }

  public void init( GameContainer container ) throws SlickException
  {
    long start = System.currentTimeMillis();
    evaler.eval(runtime, "require 'game_manager'");
    String initialState = getProperty(container, "glp_scene");
    
    IRubyObject gameClass = evaler.eval(runtime, "GameLaunchpad::GameManager");
    Object[] parameters = {container, initialState};
    game = (GameManagerBase)JavaEmbedUtils.invokeMethod(runtime, gameClass, "new", parameters, GameManagerBase.class);
    long stop = System.currentTimeMillis();
    org.newdawn.slick.util.Log.info("Spent " + (stop - start) + " milliseconds loading GameLaunchpad");
  }

  public void update( GameContainer container, int delta ) throws SlickException
  {
    try {
      game.update(container, delta);
    }
    catch(org.jruby.exceptions.RaiseException error) {
      org.newdawn.slick.util.Log.error("Error in update: " + error);
    }
  }

  public void render( GameContainer container, Graphics g ) throws SlickException
  {
    try {
      game.render(container, g);
    }
    catch(org.jruby.exceptions.RaiseException error) {
      org.newdawn.slick.util.Log.error("Error in render: " + error);
    }
  }

  public static void main( String[] args )
  {
    try
    {
      AppGameContainer app = new AppGameContainer( new GameLoader() );
      app.setDisplayMode( Integer.getInteger("width"), Integer.getInteger("height"), false );
      app.start();
    }
    catch ( SlickException e )
    {
      e.printStackTrace();
    }
  }

  private String getProperty(GameContainer container, String property)
  {
    if(container instanceof AppletGameContainer.Container)
    {
      return ((AppletGameContainer.Container)container).getApplet().getParameter(property);
    }
    else
    {
      return System.getProperty(property);
    }
  }
}