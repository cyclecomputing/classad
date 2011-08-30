require 'test/unit'
require 'time'
require File.join(File.dirname(__FILE__), "..", "lib", "classad")

class ClassAdTest < Test::Unit::TestCase
  def test_relative_time
    str = RelativeTime.new(30).to_s
    assert_equal('30', str, "thirty seconds")

    str = RelativeTime.new(30.3).to_s
    assert_equal('30.300', str, "thirty point three seconds")

    str = RelativeTime.new(30.3456).to_s
    assert_equal('30.345', str, "thirty point three four five seconds")

    str = RelativeTime.new(60).to_s
    assert_equal('1:00', str, "one minute")

    str = RelativeTime.new(60*60).to_s
    assert_equal('1:00:00', str, "one hour")

    str = RelativeTime.new(24*60*60).to_s
    assert_equal('1+00:00:00', str, "one day")

    str = RelativeTime.new(-60).to_s
    assert_equal('-1:00', str, "neg one minute")

    str = RelativeTime.new(90061.1).to_s
    assert_equal('1+01:01:01.100', str, 'one day one hour one minute one point one seconds')

  end

  def test_xml
    ad = ClassAd.new
    ad["strings"] = %w{one two three}
    ad["flag"] = true
    ad["not_flag"] = false
    ad["int"] = 123
    ad["float"] = 102.3
    ad["then"] = Time.parse('25-jun-1973')
    duration = Time.parse('9-aug-2010') - Time.parse('25-jun-1973')
    ad["duration"] = RelativeTime.new(duration)
    ad["single_string"] = "chuck_finley"
    xml = ad.to_xml

    expected = '<c><a n="duration"><rt>13558+23:00:00</rt></a><a n="flag"><b v="t"/></a><a n="int"><i>123</i></a><a n="not_flag"><b v="f"/></a><a n="strings"><l><s>one</s><s>two</s><s>three</s></l></a><a n="single_string"><s>chuck_finley</s></a><a n="then"><at>1973-06-25T00:00:00-05:00</at></a><a n="float"><r>102.3</r></a></c>'

    assert_equal(expected, xml, "classad to xml")
  end
end
