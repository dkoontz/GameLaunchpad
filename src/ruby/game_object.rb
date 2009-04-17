module GameLaunchpad
  class Easing
    def self.linear(start_value, target_value, start_time, duration)
      current_time = java.lang.System.current_time_millis
      if current_time > (start_time + duration)
        target_value
      else
        percent_complete = (current_time - start_time) / duration.to_f
        start_value + ((target_value - start_value) * percent_complete)
      end
    end

    EASE_IN_PERCENTAGE = 0.3
    def self.ease_in(start_value, target_value, start_time, duration)
      current_time = java.lang.System.current_time_millis
      if current_time > (start_time + duration)
        target_value
      else
        percent_complete = (current_time - start_time) / duration.to_f
        if percent_complete <= EASE_IN_PERCENTAGE
          easing_target = EASE_IN_PERCENTAGE * target_value
          start_value + (easing_target * ((percent_complete / EASE_IN_PERCENTAGE) ** 2))
        else
          linear(start_value, target_value, start_time, duration)
        end
      end
    end

    LINEAR = method(:linear)
    EASE_IN = method(:ease_in)
  end

  class Property
    def initialize
      @value = nil
      @target_value = nil
      @duration = nil
      @function = nil
      @last_update = nil
    end

    def value
      if @function
        @function.call(@value, @target_value, @start_time, @duration)
      else
        @value
      end
    end

    def value=(value)
      @value = value
    end

    def interpolate(from, to, duration = 0, easing = Easing::LINEAR, &block)
      @value = from
      interpolate_to(to, duration, easing, &block)
    end

    def interpolate_to(value, duration = 0, easing = Easing::LINEAR, &block)
      @target_value = value
      @duration = duration
      @start_time = java.lang.System.current_time_millis
      @function = block || easing
    end
  end

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