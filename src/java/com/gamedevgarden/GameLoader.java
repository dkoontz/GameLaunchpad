package com.gamedevgarden;

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
  RubyGame game;
  Ruby runtime;
  RubyRuntimeAdapter evaler;

  public GameLoader()
  {
    super( "Loading Game..." );
  }

  public void init( GameContainer container ) throws SlickException
  {
    // Initialize JRuby runtime
    runtime = JavaEmbedUtils.initialize(new ArrayList());
    evaler = JavaEmbedUtils.newRuntimeAdapter();
    System.out.println(container.getClass()) ;
    // Run script to get GameObject
    evaler.eval(runtime, "require 'ruby_game'");
    String id = getGameId(container);
    IRubyObject unconvertedGame = evaler.eval(runtime, "RubyGameManager.new(" + id + ")");
    game = (RubyGame) JavaEmbedUtils.rubyToJava(runtime, unconvertedGame, RubyGame.class);
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

  private String getGameId(GameContainer container)
  {
    if(container instanceof AppletGameContainer.Container)
    {
      return ((AppletGameContainer.Container)container).getApplet().getParameter("game_id");
    }
    else
    {
      return System.getProperty("game_id");
    }
  }
}