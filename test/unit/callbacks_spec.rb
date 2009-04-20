require 'callbacks'

class CallbackTest
  include GameLaunchpad::Callbacks
end

class CallbackInstanceTest
  include GameLaunchpad::Callbacks
  
  def initialize
    initialize_callback_system
  end
end

class CallbackSubclassTest < CallbackTest
  
end

describe GameLaunchpad::Callbacks do
  it "adds an 'initialize_callback_system' method" do
    CallbackTest.instance_methods.member?('initialize_callback_system').should be_true
  end
  
  it "adds a 'has_callbacks' method" do
    CallbackTest.methods.member?('has_callbacks').should be_true
  end
end

describe GameLaunchpad::Callbacks, "has_callbacks" do
  it "creates a <callback name> instance method for each callback" do
    CallbackTest.has_callbacks :before_foo, :after_bar
    CallbackTest.instance_methods.member?('before_foo').should be_true
    CallbackTest.instance_methods.member?('after_bar').should be_true
  end

  it "creates a run_<callback name>_callbacks methods for each callback" do
    CallbackTest.has_callbacks :before_foo, :after_bar
    CallbackTest.instance_methods.member?('run_before_foo_callbacks').should be_true
    CallbackTest.instance_methods.member?('run_after_bar_callbacks').should be_true
  end
end

describe GameLaunchpad::Callbacks, "<callback name>_callbacks" do
  it "calls each registered callback" do
    CallbackInstanceTest.has_callbacks :before_foo, :after_bar
    test = CallbackInstanceTest.new
    @callback_was_called = false
    test.before_foo { @callback_was_called = true }
    test.run_before_foo_callbacks
    @callback_was_called.should be_true
  end

  it "passes an optional object and options to each registered callback" do
    CallbackInstanceTest.has_callbacks :before_foo, :after_bar
    test = CallbackInstanceTest.new
    @parameters_were_passed_in = false
    test.before_foo do |object, options|
      if object && options
        @parameters_were_passed_in = true
      end
    end
    test.run_before_foo_callbacks
    @parameters_were_passed_in.should be_false
    test.run_before_foo_callbacks("just an object, options should default to {}")
    @parameters_were_passed_in.should be_true
    test.run_before_foo_callbacks("object and options", {:an => :option})
    @parameters_were_passed_in.should be_true
  end

  it "allows multiple callbacks to be registered" do
    CallbackInstanceTest.has_callbacks :before_foo, :after_bar
    test = CallbackInstanceTest.new
    @callback_run_count = 0

    test.before_foo { @callback_run_count += 1 }
    test.before_foo { @callback_run_count += 1 }
    test.run_before_foo_callbacks
    @callback_run_count.should == 2
  end

  it "stops calling callbacks when false is returned" do
    CallbackInstanceTest.has_callbacks :before_foo, :after_bar
    test = CallbackInstanceTest.new
    @callback_run_count = 0

    test.before_foo { @callback_run_count += 1; false }
    test.before_foo { @callback_run_count += 1 }
    test.run_before_foo_callbacks
    @callback_run_count.should == 1
  end

  it "allows callbacks to be inherited" do
    CallbackTest.has_callbacks :before_foo, :after_bar
    CallbackSubclassTest.has_callbacks :before_baz
    CallbackSubclassTest.instance_methods.member?('before_foo').should be_true
    CallbackSubclassTest.instance_methods.member?('after_bar').should be_true
    CallbackSubclassTest.instance_methods.member?('before_baz').should be_true
  end
end