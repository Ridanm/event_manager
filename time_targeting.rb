=begin   
El jefe ya piensa en la próxima conferencia: 
“El año que viene quiero hacer un mejor uso 
de nuestra publicidad de Google y Facebook. 
Averigüe qué horas de el día en que se registró 
la mayor cantidad de personas, por lo que podemos 
publicar más anuncios durante esas horas”. ¡Interesante!
=end
require 'csv' 

contents = CSV.open(
  '../event_attendees.csv', 
  headers: true,
  header_converters: :symbol 
)

contents.each do |row|
  puts row[:regdate]
end