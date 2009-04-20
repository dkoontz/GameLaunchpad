require 'behaviors'

class BehaviorTest
  include GameLaunchpad::Behaviors
end

class BehaviorAddTest
  include GameLaunchpad::Behaviors

  def initialize
    initialize_behavior_system
    add_behavior :foo_behavior
  end
end

describe GameLaunchpad::Behaviors do
  it "adds an 'initialize_behavior_system' method" do
    BehaviorTest.instance_methods.member?('initialize_behavior_system').should be_true
  end

  it "adds an 'add_behavior' method" do
    BehaviorTest.instance_methods.member?('add_behavior').should be_true
  end

  it "adds a 'remove_behavior' method" do
    BehaviorTest.instance_methods.member?('remove_behavior').should be_true
  end
end

describe GameLaunchpad::Behaviors, "add_behavior" do
  before(:all) do
    FooBehavior = mock("foo_behavior")
  end

  it "instantiates a new behavior" do
    FooBehavior.should_receive(:new).and_return(FooBehavior)
    BehaviorAddTest.new
  end
  
  it "adds the instantiated behavior to the list of behaviors" do
    FooBehavior.should_receive(:new).and_return(FooBehavior)
    b = BehaviorAddTest.new
    b.send(:instance_variable_get, "@behaviors")[:foo_behavior].should_not be_nil
  end

  it "doesn't allow a second behavior of the same type to be added" do
    FooBehavior.should_receive(:new).and_return(FooBehavior)
    b = BehaviorAddTest.new
    lambda do
      b.add_behavior :foo_behavior
    end.should raise_error
  end
end

describe GameLaunchpad::Behaviors, "remove_behavior" do
  before(:all) do
    FooBehavior = mock("foo_behavior")
  end

  it "calls remove on the behavior" do
    FooBehavior.should_receive(:new).and_return(FooBehavior)
    FooBehavior.should_receive(:remove)
    b = BehaviorAddTest.new
    b.remove_behavior :foo_behavior
  end

  it "removes the behavior from the list of behaviors" do
    FooBehavior.should_receive(:new).and_return(FooBehavior)
    FooBehavior.should_receive(:remove)
    b = BehaviorAddTest.new

    b.send(:instance_variable_get, "@behaviors")[:foo_behavior].should_not be_nil
    b.remove_behavior :foo_behavior
    b.send(:instance_variable_get, "@behaviors")[:foo_behavior].should be_nil
  end
  
  it "raises an exception if a behavior that was not added is removed" do
    FooBehavior.should_receive(:new).and_return(FooBehavior)
    b = BehaviorAddTest.new

    lambda do
      b.remove_behavior :does_not_exist
    end.should raise_error
  end
end