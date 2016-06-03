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

uri = ARGV[0]
puts uri
doc = Hpricot(open(uri).read)
str = doc.scrub.to_s.strip.gsub(/\s+/, " ").gsub(/\s+/, "")
$stderr.puts str
str.each_byte do |i|
  puts i %5
end

