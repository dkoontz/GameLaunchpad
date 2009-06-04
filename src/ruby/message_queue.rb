# Copyright (c) 2009 GameLaunchpad
# All rights reserved.

require 'thread'
module GameLaunchpad
  class MessageQueue

    def initialize
      @listeners = Hash.new {|h,k| h[k] = []}
      @messages = Queue.new
      @listener_hash_in_use = Mutex.new
      @continue_processing = false
    end

    def start_processing
      @continue_processing = true
      Thread.new do
        while @continue_processing
          if @messages.empty?
            sleep 0.001
            next
          end
          
          message = @messages.shift

          @listeners[message.name].each do |listener|
            begin
              listener[1].call(message)
            rescue Exception => e
              GameLaunchpad::GameManager.logger.error "Error in callback #{listener[1]} for key: #{listener[0]}\n#{e.class} - #{e.message}\n#{e.backtrace.join("\n")}"
            end
          end
        end
      end
    end

    def stop_processing
      @continue_processing = false
    end

    def post_message(message)
      @messages << message
    end

    # Listeners are registered on a certain type of message.  This type is arbitrary
    # and can be any symbol.  The second parameter is a key that is used to identify
    # the callback when it is removed.  The third parameter is the callback object
    # which must be a proc.  Alternatively, the second parameter may be omitted and a
    # block passed in its place.
    def add_listener(type, key, callback=nil, &block)
      @listener_hash_in_use.synchronize do
        @listeners[type.to_sym] << [key, callback || block]
      end
    end

    def remove_listener(type, key)
      @listener_hash_in_use.synchronize do
        @listeners[type.to_sym].delete_if {|listener| listener.first == key}
      end
    end
  end
end