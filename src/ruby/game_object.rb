require 'properties'
require 'callbacks'
require 'behaviors'

module GameLaunchpad
  class GameObject
    include GameLaunchpad::Callbacks
    include GameLaunchpad::Behaviors
    include GameLaunchpad::Properties
    
    def initialize(*args, &block)
      initialize_callback_system
      initialize_behavior_system
      load(*args, &block)
    end

    def load(*args, &block)

    end
  end
end