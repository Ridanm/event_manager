require 'colorize'

titulo = "Event manager initialize"
puts titulo.colorize(:green).center(50)

# comprobando si el archivo exist? 
does_the_file_exist = File.exist? "../event_attenddes.csv"
puts "\nExiste el archivo: #{does_the_file_exist}"

# leer el contenido de archivo completo
content = File.read('../event_attenddes.csv')
puts "\n#{content}"
puts content.class

# leyendo linea por linea
lines = File.readlines "../event_attenddes.csv"

puts lines
puts lines.class.to_s.colorize(:blue)

lines.each do |line|
  puts line
end

# convirtiendo una caden de texto en una matriz String#split
lines = File.readlines "../event_attenddes.csv"
lines.each do |line|
  content = line.colorize(:yellow).split(',')
  puts content
end

# acceder a first_name 
lines = File.readlines "../event_attenddes.csv"
lines.each do |line|
  columns = line.split(',')
  name = columns[2]
  puts name.colorize(:green)
end

# saltarse la linea de encabezado descrito de forma literal
lines = File.readlines "../event_attenddes.csv"
lines.each do |line|
  next if line == " ,RegDate,first_Name,last_Name,Email_Address,HomePhone,Street,City,State,Zipcode\n"
  content = line.split(',')
  name = content[2]
  puts name.colorize(:blue)
end

# Usando otro enfoque para saltarse la linea de encabezado
# Rastreando el índice de la linea actual
lines = File.readlines "../event_attenddes.csv"
row_index = 0
lines.each do |line|
  row_index += 1
  next if row_index == 1
  columns = line.split(',')
  names = columns[2]
  puts names.colorize(:yellow)
end

# Saltar la primera linea usando Array#each_with_index
lines = File.readlines "../event_attenddes.csv"
lines.each_with_index do |line, ind|
  next if ind == 0
  content = line.split(',')
  names = content[2]
  puts names.colorize(:green)
end
