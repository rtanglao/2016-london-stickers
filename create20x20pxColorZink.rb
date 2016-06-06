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

# from http://www.pantone.com/pages/fcr/?season=spring&year=2016&pid=11#peach-echo
six_colour_array = [ ChunkyPNG::Color.from_hex('#F7CAC9'), #rose quartz
                    ChunkyPNG::Color.from_hex('#F7786B'), #peach echo
                    ChunkyPNG::Color.from_hex('#91A8D0'), #serenity
                    ChunkyPNG::Color.from_hex('#034F84'), #snorkel blue
                    ChunkyPNG::Color.from_hex('#FAE03C'), #butter cup
                    ChunkyPNG::Color.from_hex('#98DDDE'), #limpet shell
                    ChunkyPNG::Color.from_hex('#9896A4'), #lilac grey
                    ChunkyPNG::Color.from_hex('#DD4132'), #fiesta
                    ChunkyPNG::Color.from_hex('#B18F6A'), #iced coffee
                    ChunkyPNG::Color.from_hex('#79C753') #green flash
                   ]
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
  colour = six_colour_array[byte % 10]
  rand(1..20).times do
    for row_inc in 0..19 do
      for column_inc in 0..19 do
        png[column+column_inc,row+row_inc] = colour
      end
    end
    column += 20
    puts 'column:', column
    if column == 1120
      row += 20
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


