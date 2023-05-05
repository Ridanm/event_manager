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
require 'date'

def format_hour(hour)
 hour.gsub('/', '-')
end

def peak_registration(hour)
  registration = Hash.new(0)
  hour.reduce(registration) do |hr, repit|
    hr[repit] += 1
    hr 
  end
  registration.each { |key, val| puts "Hr:#{key} registration: #{val}"}
end

contents = CSV.open(
  '../event_attendees.csv', 
  headers: true,
  header_converters: :symbol 
)

rush_hour = []
contents.each do |row|
  date_time = format_hour(row[:regdate])
  result = Time.parse(date_time[-5..-1])
  hours = result.strftime("%H")
  rush_hour << hours 
end

puts "\nRegistration hours: "
peak_registration(rush_hour)












