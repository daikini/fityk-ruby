require 'test/unit'
require 'fityk'
require 'fityk/engine'
require 'rubygems'
require 'mocha'

class Driver
end

class EngineTest_Init < Test::Unit::TestCase
  def test_new
    driver = mock()
    driver.expects(:open).with(:driver => Driver)
    Driver.expects(:new).returns(driver)
    
    engine = Fityk::Engine.new(:driver => Driver)
  end
  
  def test_new_with_invalid_driver
    exception = assert_raise(LoadError) do
      engine = Fityk::Engine.new(:driver => "foo")
    end
    assert_equal "no such file to load -- fityk/driver/foo/driver", exception.message
    
    exception = assert_raise(LoadError) do
      engine = Fityk::Engine.new(:driver => :bar)
    end
    assert_equal "no such file to load -- fityk/driver/bar/driver", exception.message
  end
  
  def test_new_with_native_driver
    begin
      require 'fityk/driver/native/driver'
      
      Fityk::Driver::Native::API::Fityk.expects(:new)
      assert_nothing_raised do
        engine = Fityk::Engine.new
      end
    rescue LoadError => e
      exception = assert_raise(RuntimeError) do
        engine = Fityk::Engine.new
      end
      assert_equal "no driver for fityk found", exception.message
    end
  end
end

class EngineTest < Test::Unit::TestCase
  def setup
    @driver = mock()
    @handle = mock()
    @driver.expects(:open).with(anything).returns(@handle)
    Driver.expects(:new).returns(@driver)
    
    @engine = Fityk::Engine.new(:driver => Driver)
  end
  
  def test_call
    @driver.expects(:call).with(@handle, :some_function_name, "argument 1", "argument 2")
    @engine.some_function_name "argument 1", "argument 2"
  end
  
end