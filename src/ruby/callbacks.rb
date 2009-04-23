# This code is loosley inspired from the the Ruby on Rails project (http://www.rubyonrails.com)
# Big thanks to Yehuda Katz for his original reworked version of these classes.

module GameLaunchpad
  module Callbacks
    def self.included(base)
      base.extend ClassMethods
      base.send(:include, InstanceMethods)
    end
  end

  module InstanceMethods
    def initialize_callback_system
      @__callbacks = Hash.new { |hash,key| hash[key] = {} }
      @random_callback_id = 0
    end
  end

  module ClassMethods
    def has_callbacks(*names)
      names.each do |callback_name|
        class_eval <<-"ENDL", __FILE__, __LINE__ + 1
          def #{callback_name}(key = (@random_callback_id += 1), &block)
            @__callbacks[:#{callback_name}][key] = block
          end

          def run_#{callback_name}_callbacks(object = nil, options = {})
            @__callbacks[:#{callback_name}].each do |key, callback|
              break if !callback.call(object, options)
            end
          end
        ENDL
      end
    end
  end
end