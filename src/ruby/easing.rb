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

    # Exponential easing
    # slope * ((end_time - start_time) ** 2) + start_value = end_value
    def self.ease_in(start_value, target_value, start_time, current_time, duration)
      if current_time > (start_time + duration)
        target_value
      else
        value_delta = end_value - start_value
        time_delta = start_time + duration
        slope = value_delta / (time_delta ** 2)
        (slope * ((current_time - start_time) ** 2)) + start_value
      end
    end

    LINEAR = method(:linear)
    EASE_IN = method(:ease_in)
  end
end