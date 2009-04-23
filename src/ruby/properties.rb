require 'property'

module GameLaunchpad
  module Properties
    def self.included(base)
      base.extend PropertyClassMethods
      base.send(:include, PropertyInstanceMethods)
    end
  end

  module PropertyInstanceMethods

  end

  module PropertyClassMethods
    def property(*properties)
      properties.each do |property|
        class_eval <<-ENDL
          def #{property}
            @#{property} = Property.new unless @#{property}
            @#{property}
          end
        ENDL
      end
    end
  end
end