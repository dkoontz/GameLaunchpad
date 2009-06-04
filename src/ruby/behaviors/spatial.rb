# Copyright (c) 2009 GameLaunchpad
# All rights reserved.

class Spatial < GameLaunchpad::BaseBehavior
  property :x, :y

  def load
    declare_methods :x, :y
  end
end