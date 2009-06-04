# Copyright (c) 2009 GameLaunchpad
# All rights reserved.

# A message is a data object that is posted to the MessageQueue.
# It is a simple key/value data object where the name distinguishes
# who recieves the message (only callbacks registered with the
# message name).
class Message
  attr_accessor :name, :value
  def initialize(name, value)
    @name = name
    @value = value
  end
end