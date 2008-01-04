$:.unshift "../../../lib"
require 'test/unit'
require 'fityk'
require 'fityk/driver/native/driver'
require 'rubygems'
require 'mocha'

class DriverTest < Test::Unit::TestCase
  include Fityk::Driver::Native
  
  def setup
    @driver = Driver.new
  end
  
  def test_open
    fityk = stub()
    API::Fityk.expects(:new).returns(fityk)
    assert_equal fityk, @driver.open
  end
  
  def test_call
    result = stub()
    fityk = mock()
    fityk.expects(:some_method_name).with("argument 1", "argument 2").returns(result)
    assert_equal result, @driver.call(fityk, :some_method_name, "argument 1", "argument 2")
  end
end