= classad

http://github.com/cyclecomputing/classad
http://www.cyclecomputing.com

== DESCRIPTION:

ClassAd wraps the Hash object with code to create an xml doc representing a Condor ClassAd

== FEATURES/PROBLEMS:

* load ClassAd just like any Hash
* xml output
* helper class for Condor relTime type

== SYNOPSIS:

  require 'classad'

  ad = ClassAd.new
  ad['AdType'] = "MyType"
  ad['Birthday'] = Time.parse('1-jan-2003')
  
  puts ad.to_xml

== REQUIREMENTS:

* builder

== INSTALL:

* sudo gem install classad

== DEVELOPERS:

After checking out the source, run:

  $ rake newb

This task will install any missing dependencies, run the tests/specs,
and generate the RDoc.

== LICENSE:

Copyright 2010 Cycle Computing LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
