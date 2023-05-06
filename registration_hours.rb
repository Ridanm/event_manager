=begin   
El jefe ya piensa en la próxima conferencia: 
“El año que viene quiero hacer un mejor uso 
de nuestra publicidad de Google y Facebook. 
Averigüe qué horas de el día en que se registró 
la mayor cantidad de personas, por lo que podemos 
publicar más anuncios durante esas horas”
Concluded for now
=end
require 'csv' 
require 'time'
require 'colorize'

def text_color(text, color)
  {
    'green' => text.colorize(:green),
    'yellow' => text.colorize(:yellow),
    'red' => text.colorize(:red)
  }[color]
end

def format_hours(data)
  result = Time.strptime(data, '%m/%d/%Y %H:%M')
  result.strftime('%H')
end

def peak_registration(hour)
  registration = Hash.new(0)
  hour.reduce(registration) do |hr, repit|
    hr[repit] += 1
    hr 
  end
  registration.each do |key, val|
     puts "#{text_color('Hour: ', 'green')} #{key}, #{text_color('registration: ', 'yellow')} #{val}"
  end
end

contents = CSV.open(
  '../event_attendees.csv', 
  headers: true,
  header_converters: :symbol 
)

rush_hour = []
contents.each do |row|
  date_time = format_hours(row[:regdate])
  rush_hour << date_time
end

text = 'Times checked in per hour'
space = text.size 
title = text_color(text, 'green')
puts "\n#{title.center(space*2)}\n\n"
peak_registration(rush_hour)












