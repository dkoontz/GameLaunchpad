class Spatial < GameLaunchpad::BaseBehavior
  property :x, :y

  def load
    declare_methods :x, :y
  end
end