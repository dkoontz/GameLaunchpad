package com.gamelaunchpad;

import java.util.ArrayList;
import org.newdawn.slick.BasicGame;
import org.newdawn.slick.GameContainer;
import org.newdawn.slick.Graphics;
import org.newdawn.slick.SlickException;
import org.newdawn.slick.AppGameContainer;

import org.jruby.Ruby;
import org.jruby.RubyRuntimeAdapter;
import org.jruby.javasupport.JavaEmbedUtils;
import org.jruby.runtime.builtin.IRubyObject;
import org.newdawn.slick.AppletGameContainer;

public class GameLoader extends BasicGame
{
  GameManagerBase game;
  Ruby runtime;
  RubyRuntimeAdapter evaler;

  public GameLoader()
  {
    super( "Loading Game..." );
  }

  public void init( GameContainer container ) throws SlickException
  {
    runtime = JavaEmbedUtils.initialize(new ArrayList());
    evaler = JavaEmbedUtils.newRuntimeAdapter();
    System.out.println(container.getClass()) ;

    evaler.eval(runtime, "require 'game_manager'");
    String initialState = getProperty(container, "glp_scene");
    
    IRubyObject gameClass = evaler.eval(runtime, "GameLaunchpad::GameManager");
    Object[] parameters = {container, initialState};
    game = (GameManagerBase)JavaEmbedUtils.invokeMethod(runtime, gameClass, "new", parameters, GameManagerBase.class);
  }

  public void update( GameContainer container, int delta ) throws SlickException
  {
    game.update(container, delta);
  }

  public void render( GameContainer container, Graphics g ) throws SlickException
  {
    try
    {
      game.render(container, g);
    }
    catch(org.jruby.exceptions.RaiseException error)
    {
      org.newdawn.slick.util.Log.error("Error evaluating Ruby string", error);
    }
  }

  public static void main( String[] args )
  {
    try
    {
      AppGameContainer app = new AppGameContainer( new GameLoader() );
      app.setDisplayMode( 300, 200, false );
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