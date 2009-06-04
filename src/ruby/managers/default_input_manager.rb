# Copyright (c) 2009 GameLaunchpad
# All rights reserved.

include_class 'org.newdawn.slick.Input'
include_class 'org.newdawn.slick.InputListener'

require 'message'

module GameLaunchpad
  class Keymap
    include InputListener
    
    def initialize(message, manager)
      @message = message
      @manager = manager
      @key_pressed_listeners = {}
      @key_released_listeners = {}
      @key_held_listeners = {}
    end

    # Takes a symbol that can be mapped to a constant on the
    # org.newdawn.slick.Input class.  For example, :right maps to
    # Input::KEY_RIGHT, :a maps to Input::KEY_A
    def key_held(key)
      @key_held_listeners[translate_to_slick_constant(key)] = nil
    end

    def key_pressed(key)
      
    end

    def key_released(key)
      
    end

    # Update is what triggers non-event based checks
    # such as key_held
    def update(delta)
      @key_held_listeners.each do |key_code, value|
        if @manager.slick_input.key_down? key_code
          # post message
          @manager.scene.message_queue.post_message Message.new(@message, nil)
        end
      end
    end

    # Implement methods from interface
    def keyPressed(key_code, character)

    end

    def keyReleased(key_code, character)

    end

  private
    def translate_to_slick_constant(key)
      Input.const_get("KEY_#{key}".upcase)
    end
  end

  class DefaultInputManager < Manager
    attr_reader :slick_input, :scene
    
    def load
      initialize_input
      @mappings = Hash.new {|hash, message| hash[message] = Keymap.new(message, self)}
    end

    def update(delta)
      GameLaunchpad::GameManager.logger.warn "updating #{@mappings.values.size} mappings"
      @mappings.values.each { |mapping|
        GameLaunchpad::GameManager.logger.warn "#{mapping.class}"
        mapping.update(delta)
      }
    end

    def map(message)
      yield @mappings[message]
    end

    # This is used to set up the input object that is queried for the
    # state of keys and buttons.  The input system relies on knowing
    # the height of the screen so any action that changes resolution
    # needs to call this method.
    def initialize_input
      @slick_input = Input.new(@scene.container.height)
    end
  end
end

#map :fire do
#  with_held_key :x
#  with_held_joystick_button :xbox_button_a
#end
#
#map :adjust_angle do
#  with_held_key :left, :value => ANGLE_RATE
#  with_joystick_axis :xbox_axis_update do |message, raw_input|
#    message.value = filter_dead_zone(0.2, message.value)
#  end
#end