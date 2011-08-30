# -*- ruby -*-

require 'rubygems'
require 'hoe'

# copy README.rdoc to README.txt
FileUtils.cp File.join(File.dirname(__FILE__), 'README.rdoc'), File.join(File.dirname(__FILE__), 'README.txt') 

# we don't use rubyforge
Hoe.plugins.delete :rubyforge

Hoe.spec 'classad' do
  developer('Chris Chalfant', 'chris.chalfant@cyclecomputing.com')
  extra_deps << ['builder']
end
