module GameLaunchpad
  class Easing
    def self.linear(start_value, target_value, start_time, current_time, duration)
      if current_time > (start_time + duration)
        target_value
      else
        percent_complete = (current_time - start_time) / duration.to_f
        start_value + ((target_value - start_value) * percent_complete)
      end
    end

    EASE_IN_PERCENTAGE = 0.3
    def self.ease_in(start_value, target_value, start_time, current_time, duration)
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
end