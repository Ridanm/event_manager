require 'csv'
require 'date'
require 'colorize'

def format_data(data)
  result = Date.strptime(data, '%m/%d/%Y')
  result.strftime('%A')
end

def text_color(text, color)
  {
    'green' => text.colorize(:green),
    'yellow' => text.colorize(:yellow),
  }[color]
end

contents = CSV.open(
  '../event_attendees.csv', 
  headers: true,
  header_converters: :symbol
)

text = 'Registration day of each people'
space = text.size 
title = text_color(text, 'green')
puts "\n#{title.center(space*2)}\n\n"

contents.each do |row|
  date_time = format_data(row[:regdate])
  print text_color(" Registration day: ", 'green') 
  puts text_color(date_time, 'yellow')
end

