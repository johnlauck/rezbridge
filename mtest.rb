#!/usr/bin/env ruby

r = '<?xml version="1.0"?>
<Response> GetClock
<Parameter1>12/27/2007 00:58:59</Parameter1>
<Parameter2>12/27/2007 00:58:59</Parameter2>
</Response>
'

mr = /<\?xml version="1.0"\?>\n<Response> \w+\n(<Parameter\d+>.*<\/Parameter\d+>\n)+<\/Response>\n/

if mr =~ r
  puts 'match'
else
  puts 'no match'
end