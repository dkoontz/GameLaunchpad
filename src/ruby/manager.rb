require 'callbacks'

module GameLaunchpad
  class Manager
    include GameLaunchpad::Callbacks

    def initialize(scene)
      @scene = scene
      load
    end

    def load

    end
  end
end