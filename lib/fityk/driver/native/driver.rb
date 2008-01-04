begin
  require 'fityk_api'
rescue LoadError
  require File.dirname(__FILE__) + '/../../../../ext/fityk_api/fityk_api'
end

module Fityk ; module Driver ; module Native
  class Driver
    def open(options = {})
      API::Fityk.new
    end
    
    def call(handle, method_id, *args)
      handle.send(method_id, *args)
    end
  end
end ; end ; end