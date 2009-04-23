require 'game_object'

describe GameLaunchpad::GameObject, "#property" do
  class PropertyTestGameObject < GameLaunchpad::GameObject
    property :foo
  end

  it "adds a property accessor to the class" do
    @prop_test = PropertyTestGameObject.new
    @prop_test.foo.class.should == GameLaunchpad::Property
  end

  class MultiplePropertyTestGameObject < GameLaunchpad::GameObject
    property :foo, :bar, :baz
  end

  it "allows the addition of multiple properties" do
    @prop_test = MultiplePropertyTestGameObject.new
    @prop_test.foo.class.should == GameLaunchpad::Property
    @prop_test.bar.class.should == GameLaunchpad::Property
    @prop_test.baz.class.should == GameLaunchpad::Property
  end
end