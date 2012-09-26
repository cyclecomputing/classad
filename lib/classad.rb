# classad.rb
#
# Extensions to Ruby Hash to generate Classified Ad xml format described at 
# http://www.cs.wisc.edu/condor/classad/
#
# Author: Chris Chalfant (chris.chalfant@cyclecomputing.com)
#
# Copyright 2010 Cycle Computing LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'rubygems'
require 'builder'
require 'time'

# Wrapper for Ruby "seconds" variable so ClassAd
# knows this is a relTime and can write the xml appropriately
class RelativeTime
  def initialize(t)
    @time = t
  end

  def to_s
    str = ''
    nonzero = false
    left = @time

    if @time < 0
      str << '-'
      left = -@time
    end

    days = (left / (24*60*60)).to_i
    left = left % (24*60*60)

    unless days.zero?
      str << days.to_i.to_s << '+' 
      nonzero = true
    end

    hours = (left / (60*60)).to_i
    left = left % (60*60)
    
    if (not hours.zero?) or nonzero
      if nonzero and (hours < 10)
        str << "0"
      end

      str << hours.to_i.to_s << ':'
      nonzero = true
    end

    minutes = (left / 60).to_i
    left = left % 60

    if (not minutes.zero?) or nonzero
      if nonzero and (minutes < 10)
        str << "0"
      end

      str << minutes.to_i.to_s << ":"
      nonzero = true
    end

    seconds = left.to_i
    mseconds = ((left - seconds) * 1000).to_i
    
    if nonzero and (seconds < 10)
      str << "0"
    end
    
    str << seconds.to_s 
    
    unless mseconds.zero?
      str << "."
      if mseconds < 100
        str << "0"
        if mseconds < 10
          str << "0"
        end
      end
      str << mseconds.to_s
    end

    return str
  end
end

class ClassAd < Hash

  VERSION = '1.2.1'

  def to_xml(pretty=false)
    opts = {}
    if pretty
      opts[:indent] = 2
    end
    xml = Builder::XmlMarkup.new(opts)
    xml.c do
      self.each do |k,v|
        add_attribute(xml,k,v)
      end
    end
  end

  private

  def add_attribute(builder, name, value)
    builder.a("n" => name) do
      
      if value.respond_to?(:each) and value.is_a?(String) == false
        builder.l do
          value.each do |v|
            add_literal(builder, v)
          end
        end
      else
        add_literal(builder, value)
      end
      
    end  
  end

  def add_literal(builder, literal)
    case literal
    when Float
      # this may have to be in sci notation
      builder.r(literal)
    when Integer, Fixnum, Bignum
      builder.i(literal)
    when TrueClass, FalseClass
      builder.b("v" => literal ? 't' : 'f')
    when NilClass
      builder.un
    when Time
      builder.at(literal.iso8601)
    when RelativeTime
      builder.rt(literal.to_s)
    when String
      builder.s( xmlescape(literal) )
    end
  end

  def xmlescape(str)
    # http://stackoverflow.com/questions/1542214/weird-backslash-substitution-in-ruby
    str.gsub('<','&lt;').gsub('&','&amp;').gsub('>','&gt;').gsub('\\') {'\\\\'}
  end

end
