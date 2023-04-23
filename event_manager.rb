require 'colorize'

titulo = "Event manager initialize"
puts titulo.colorize(:green).center(50)

does_the_file_exist = File.exist? "../event_attenddes.csv"
puts "\nExiste el archivo: #{does_the_file_exist}"

content = File.read('../event_attenddes.csv')
puts "\n#{content}"
puts content.class

lines = File.readlines "../event_attenddes.csv"

puts lines
puts lines.class
