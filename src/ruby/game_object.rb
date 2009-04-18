require 'property'

module GameLaunchpad
  class GameObject
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
  end
end