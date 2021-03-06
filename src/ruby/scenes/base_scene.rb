# Copyright (c) 2009 GameLaunchpad
# All rights reserved.

require 'managers/default_game_object_manager'
require 'managers/default_render_manager'
require 'managers/default_update_manager'
require 'managers/default_input_manager'
require 'message_queue'

module GameLaunchpad
  class BaseScene
    attr_reader :container, :message_queue
    
    def initialize(game_manager, container)
      @game_manager = game_manager
      @container = container
      @managers = {:game_object => nil,
                   :render => nil,
                   :update => nil,
                   :input => nil
                  }
      load
    end

    def manager(name)
      @managers[name]
    end

    def load
      @managers[:game_object] = DefaultGameObjectManager.new(self)
      @managers[:render] = DefaultRenderManager.new(self)
      @managers[:update] = DefaultUpdateManager.new(self)
      @managers[:input] = DefaultInputManager.new(self)
      @message_queue = MessageQueue.new
      @message_queue.start_processing
    end

    def game_object_manager
      @managers[:game_object]
    end

    def render_manager
      @managers[:render]
    end

    def update_manager
      @managers[:update]
    end

    def input_manager
      @managers[:input]
    end
  end
end