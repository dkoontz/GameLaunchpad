# Copyright (c) 2009 GameLaunchpad
# All rights reserved.

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
    # Using y=x^2 curve, normalize duration to 1, find what percentage current point
    # in time is, then calculate the y for that point.  Scale by total value delta
    # for interpolation.
    # y = (percent_of_time ^ 2) * value_delta
    # current_y = y + start_value
    def self.ease_in(start_value, target_value, start_time, current_time, duration)
      if current_time > (start_time + duration)
        target_value
      else
        value_delta = target_value - start_value
        time_delta = (current_time - start_time).to_f
        start_value + (((time_delta / duration) ** 2) * value_delta)
      end
    end

    LINEAR = method(:linear)
    EASE_IN = method(:ease_in)
  end
end