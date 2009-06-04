# Copyright (c) 2009 GameLaunchpad
# All rights reserved.

require 'callbacks'

module GameLaunchpad
  class Manager
    include GameLaunchpad::Callbacks

    def initialize(scene)
      initialize_callback_system
      @scene = scene
      load
    end

    def load

    end
  end
end