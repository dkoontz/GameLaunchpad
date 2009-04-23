require 'behaviors'
require 'behaviors/base_behavior'

class TestBehavior < GameLaunchpad::BaseBehavior
  def load
    declare_methods :foo, :bar, :baz
  end
  
  def foo; end
  def bar(a, b, c); end
  def baz(*a); end
  def dont_add; end
end

class TestGameObject
  include GameLaunchpad::Behaviors
  
  def initialize
    initialize_behavior_system
    add_behavior :test_behavior
  end
end

describe GameLaunchpad::BaseBehavior, "#declare_methods" do
  it "adds declared methods to the target object" do
    object = TestGameObject.new

    TestGameObject.instance_methods.member?('foo').should be_false
    object.methods.member?('foo').should be_true
    object.method(:foo).arity.should == 0

    TestGameObject.instance_methods.member?('bar').should be_false
    object.methods.member?('bar').should be_true
    object.method(:bar).arity.should == 3

    TestGameObject.instance_methods.member?('baz').should be_false
    object.methods.member?('baz').should be_true
    object.method(:baz).arity.should == -1

    TestGameObject.instance_methods.member?('dont_add').should be_false
    object.methods.member?('dont_add').should be_false
  end
end

describe GameLaunchpad::BaseBehavior, "#remove" do
  it "removes declared methods from the target object" do
    object = TestGameObject.new
    object.methods.member?('foo').should be_true
    object.methods.member?('bar').should be_true
    object.methods.member?('baz').should be_true

    object.remove_behavior(:test_behavior)
    
    object.methods.member?('foo').should be_false
    object.methods.member?('bar').should be_false
    object.methods.member?('baz').should be_false
  end
end