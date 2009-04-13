require 'managers/default_render_manager'
require 'managers/default_update_manager'
require 'managers/default_input_manager'

module GameLaunchpad
  class BaseScene
    def initialize(container)
      @container = container
      @managers = {:render => nil,
                   :update => nil,
                   :input => nil
                  }
      load
    end

    def manager(name)
      @managers[name]
    end

    def load
      @managers[:render] = DefaultRenderManager.new(self)
      @managers[:update] = DefaultUpdateManager.new(self)
      @managers[:input] = DefaultInputManager.new(self)
    end
  end
end