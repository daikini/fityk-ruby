# Loads mkmf which is used to make makefiles for Ruby extensions
require 'mkmf'

SWIG_WRAP = "fityk_api_wrap.cxx"

fityk_dirs = dir_config( "fityk", "/usr/local/include", "/usr/local/lib" )

CONFTEST_C = "conftest.cc"

if have_header( "fityk.h" ) && have_library( "fityk" )
  if !File.exists?( SWIG_WRAP ) || with_config( "swig", false )
    swig_includes = (fityk_dirs.any? ? (fityk_dirs.collect { |dir| "-I#{dir}" }.join(" ")) : nil)
    puts "creating #{SWIG_WRAP}"
    system "swig -c++ -ruby #{swig_includes} fityk_api.i" or raise "could not build wrapper via swig (perhaps swig is not installed?)"
  end
  
  if Config::CONFIG["arch"] =~ /-darwin\d/
    CONFIG['LDSHARED'] = "g++ -pipe -bundle"
  else
    CONFIG['LDSHARED'] = "g++ -shared"
  end
  create_makefile( "fityk_api" )
end
