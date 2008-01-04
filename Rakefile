# -*- ruby -*-

require 'rubygems'
require 'hoe'
require './lib/fityk/version.rb'

Hoe.new('fityk-ruby', Fityk::Version::STRING) do |p|
  p.rubyforge_name = 'fityk-ruby'
  p.author = ["Jonathan Younger"]
  p.email = ["jonathan.younger@lipomics.com"]
  p.summary = "A Ruby interface to the fityk peak fitting software."
  p.description = p.paragraphs_of('README.txt', 2..5).join("\n\n")
  p.url = "http://fityk-ruby.rubyforge.org/"
  p.changes = p.paragraphs_of('History.txt', 0..1).join("\n\n")
  p.spec_extras["extensions"] = "ext/fityk_api/extconf.rb"
end

# vim: syntax=Ruby
