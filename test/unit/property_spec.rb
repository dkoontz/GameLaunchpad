module GameLaunchpad
  class GameManager
    def self.current_time
      @@current_time
    end

    def self.current_time=(value)
      @@current_time = value
    end
  end
end

require 'game_object'

describe GameLaunchpad::Property do
  before(:each) do
    @property = GameLaunchpad::Property.new
  end

  it "starts will a nil value" do
    @property.value.should be_nil
  end

  it "allows a value to be set and retrieved" do
    @property.value = 20
    @property.value.should == 20
  end
end

describe GameLaunchpad::Property, "interpolate_to" do
  before(:each) do
    @property = GameLaunchpad::Property.new
  end

  it "interpolates linearly by default" do
    GameLaunchpad::GameManager.current_time = 0
    @property.value = 0
    @property.interpolate_to(100, 10)

    @property.value.should == 0
    GameLaunchpad::GameManager.current_time = 1
    @property.value.should == 10
    GameLaunchpad::GameManager.current_time = 3
    @property.value.should == 30
    GameLaunchpad::GameManager.current_time = 6
    @property.value.should == 60
    GameLaunchpad::GameManager.current_time = 10
    @property.value.should == 100
  end

  def switch_halfway(start_value, target_value, start_time, current_time, duration)
    if (current_time - start_time) >= (duration / 2)
      "second"
    else
      "first"
    end
  end

  it "allows a proc object to be set to determine the value" do
    GameLaunchpad::GameManager.current_time = 0
    @property.value = 0
    @property.interpolate_to(100, 10, method(:switch_halfway))
    @property.value.should == "first"
    GameLaunchpad::GameManager.current_time = 6
    @property.value.should == "second"
  end

  it "allows a block to be set to determine the value" do
    GameLaunchpad::GameManager.current_time = 0
    @property.value = 0
    @property.interpolate_to(100, 10) do |start_value, target_value, start_time, current_time, duration|
      if (current_time - start_time) >= (duration / 2)
        "second"
      else
        "first"
      end
    end
    @property.value.should == "first"
    GameLaunchpad::GameManager.current_time = 6
    @property.value.should == "second"
  end

  it "removes any block/proc when the interpolation duration is reached" do
    GameLaunchpad::GameManager.current_time = 0
    @property.value = 0
    @property.interpolate_to(100, 10) do |start_value, target_value, start_time, current_time, duration|
      "in block"
    end
    @property.value.should == "in block"
    GameLaunchpad::GameManager.current_time = 5
    @property.value.should == "in block"
    GameLaunchpad::GameManager.current_time = 9.9
    @property.value.should == "in block"
    GameLaunchpad::GameManager.current_time = 10
    @property.value.should == 100
  end
end