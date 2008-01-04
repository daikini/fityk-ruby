fityk-ruby
    http://fityk-ruby.rubyforge.org/
    jonathan.younger@lipomics.com
    A big thank you to Lipomics Technologies, Inc. http://www.lipomics.com for sponsoring this project.
    
== DESCRIPTION:
  
A Ruby interface to the fityk peak fitting software.

== FEATURES:
  
* Call fityk functions and pass data back and forth between Ruby and fityk.

== USAGE:

  require 'fityk'
  
  fityk = Fityk::Engine.new
  fityk.get_info("version", true).split("\n")
  
  fityk.load_data 0, [1,2,3], [4,5,6], [7,8,9]
  fityk.get_data.entries.first
  fityk.get_data.entries.first.x
  fityk.get_data.entries.first.y
  fityk.get_data.entries.first.sigma

== REQUIREMENTS:

* fityk
* GCC or some other compiler to build the included extension
* SWIG (If you want to recompile the SWIG wrapper)
* Mocha (For testing only)

== INSTALL:

Simply do the following, after installing MATLAB:

  * ruby setup.rb config
  * ruby setup.rb setup
  * ruby setup.rb install

Alternatively, you can download and install the RubyGem package for
fityk-ruby (you must have RubyGems and MATLAB installed, first):

  * gem install fityk-ruby

If you have MATLAB installed in a non-standard location, you can specify the location of the include and lib files by doing:

  * gem install fityk-ruby -- --with-fityk-include=/usr/local/include \
     --with-fityk-lib=/usr/local/lib

Also, the gem ships with the C++ source-code pre-built, so 
you do not need to have SWIG installed. However, if you have SWIG installed
and you want to generate the C++ file yourself, you can specify the
<code>--with-swig</code> option.

== LICENSE

fityk-ruby is licensed under the GPL License.

Copyright (c) 2007 Jonathan Younger <jonathan.younger@lipomics.com>