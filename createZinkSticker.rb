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

green_array = [ 0xC3DBB4, 0xD3E2B6, 0xAACCB1, 0x87BDB1, 0x68B3AF]
uri = ARGV[0]
puts uri
doc = Hpricot(open(uri).read)
str = doc.scrub.to_s.strip.gsub(/\s+/, " ").gsub(/\s+/, "")
$stderr.puts str
str.each_byte do |byte|
  puts green_array[byte % 5]
end

