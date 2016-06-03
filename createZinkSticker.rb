#!/usr/bin/env ruby
require 'rubygems'
require 'pp'
require 'hpricot_scrub'
require 'open-uri'
require 'uri'

if ARGV.length < 1
  puts "usage: #{$0} uri"
  exit
end

green_array = [ [0xC3, 0xDB, 0xB4], [0xD3, 0xE2, 0xB6],
                [0xAA, 0xCC, 0xB1],  [0x87, 0xBD, 0xB1],
                 [0x68, 0xB3, 0xAF]]
uri = ARGV[0]
puts uri
doc = Hpricot(open(uri).read)
str = doc.scrub.to_s.strip.gsub(/\s+/, " ").gsub(/\s+/, "")
$stderr.puts str
str.each_byte do |byte|
  r,g,b = green_array[byte % 5][0],green_array[byte % 5][1],
          green_array[byte % 5][2]
  $stderr.printf("r:%d, g:%d, b:%d\n",r,g, b)
end

