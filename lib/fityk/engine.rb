module Fityk
  
  # The Engine class encapsulates a single connection to a Fityk instance.
  # Usage:
  #
  #   require 'fityk'
  # 
  #   fityk = Fityk::Engine.new
  #   fityk.get_info("version", true).split("\n")
  #
  #   fityk.load_data 0, [1,2,3], [4,5,6], [7,8,9]
  #   fityk.get_data.entries.first
  #   fityk.get_data.entries.first.x
  #   fityk.get_data.entries.first.y
  #   fityk.get_data.entries.first.sigma
  #
  # Values are sent to and from Fityk by calling a method on the
  # engine with the method name of interest.
  class Engine
    # The low-level opaque engine handle that this object wraps.
    attr_reader :handle

    # A reference to the underlying Fityk driver used by this engine.
    attr_reader :driver
    
    # Create a new Engine object that connects to Fityk via the given driver
    def initialize(options = {})
      load_driver(options[:driver])
      
      @handle = @driver.open(options)
    end
    
    # Call Fityk passing in the arguments
    def method_missing(method_id, *args)
      @driver.call(@handle, method_id, *args)
    end
      
    private
      # Loads the corresponding driver, or if it is nil, attempts to locate a
      # suitable driver.
      def load_driver(driver)
        case driver
          when Class
            # do nothing--use what was given
          when Symbol, String
            require "fityk/driver/#{driver.to_s.downcase}/driver"
            driver = Fityk::Driver.const_get(driver)::Driver
          else
            [ "Native" ].each do |d|
              begin
                require "fityk/driver/#{d.downcase}/driver"
                driver = Fityk::Driver.const_get(d)::Driver
                break
              rescue SyntaxError
                raise
              rescue ScriptError, Exception, NameError
              end
            end
            raise "no driver for fityk found" unless driver
        end

        @driver = driver.new
      end
  end
end
