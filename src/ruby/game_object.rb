require 'property'

module GameLaunchpad
  class GameObject
    include GameLaunchpad::Callbacks

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

    def initialize
      initialize_callback_system
      load
    end

    def load

    end
  end
end