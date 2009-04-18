require 'easing'

module GameLaunchpad
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
        if (GameManager.current_time - @start_time) >= @duration
          @function = nil
          @value = @target_value
        else
          @function.call(@value, @target_value, @start_time, GameManager.current_time, @duration)
        end
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
      @start_time = GameManager.current_time
      @function = block || easing
    end
  end
end