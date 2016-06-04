#!/usr/bin/env ruby
require 'rubygems'
require 'pp'
require 'hpricot_scrub'
require 'open-uri'
require 'uri'
require 'oily_png'

if ARGV.length < 2
  puts "usage: #{$0} uri png_filename"
  exit
end

six_colour_array = [ ChunkyPNG::Color.from_hex('#C3DBB4'),
                    ChunkyPNG::Color.from_hex('#D3E2B6'),
                    ChunkyPNG::Color.from_hex('#AACCB1'),
                    ChunkyPNG::Color.from_hex('#87BDB1'),
                    ChunkyPNG::Color.from_hex('#68B3AF'),
                    ChunkyPNG::Color.from_hex('#F62A00')]
uri = ARGV[0]
puts uri
doc = Hpricot(open(uri).read)
str = doc.scrub.to_s.strip.gsub(/\s+/, " ").gsub(/\s+/, "")
$stderr.puts str.length
column, row = 0, 0
png = ChunkyPNG::Image.new(1120, 620, ChunkyPNG::Color::TRANSPARENT)
output_jpg = false
str.each_byte do |byte|
  $stderr.printf("column:%d, row:%d\n", column, row)
  colour = six_colour_array[byte % 6]
  rand(1..100).times do
    for row_inc in 0..3 do
      for column_inc in 0..3 do
        png[column+column_inc,row+row_inc] = colour
      end
    end
    column += 4
    puts 'column:', column
    if column == 1120
      row += 4
      column = 0
    end
    puts 'row:', row

    if row == 620
      output_jpg = true
      break
    end
  end
  break if output_jpg
end
png.save(ARGV[1])


