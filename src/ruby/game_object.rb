require 'property'
require 'callbacks'

module GameLaunchpad
  class GameObject
    include GameLaunchpad::Callbacks
    include GameLaunchpad::Behaviors

    def self.property(*properties)
      properties.each do |property|
        eval <<-ENDL
          def #{property}
            @#{property} = Property.new unless @#{property}
            @#{property}
          end
        ENDL
      end
    end

    def initialize(*args, &block)
      initialize_callback_system
      load(*args, &block)
    end

    def load(*args, &block)

    end
  end
end