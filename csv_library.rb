# Analizando archivo con la biblioteca csv

require 'csv'
require 'colorize'

title = 'EventManager initialized.'

def show_string(str) 
  space = str.size
  str.colorize(:green).rjust(space*3)
end
puts show_string(title)

# Acceder a las columnas por índice
contents = CSV.open "../event_attendees.csv", headers: true 
contents.each do |row|
  name = row[2]
  puts name.colorize(:yellow)
end

# Acceder a los columnas por nombre 
contents = CSV.open "../event_attendees.csv", headers: true, header_converters: :symbol 
contents.each do |row|
  name = row[:first_name]
  puts name.colorize(:blue)
end

# Accediendo a nombres y códigos postales
contents = CSV.open "../event_attendees.csv", headers: true, header_converters: :symbol 
contents.each do |row|
  name = row[:first_name]
  zip_code = row[:zipcode]

  puts "Name: #{name}   zipcode: #{zip_code}"
end

# # El nombre más largo 
# def long(space)
#   long = []
#   long << space
#   mayor = long[0]
  
#   for x in 0..long.length
#     if space[x] > mayor 
#       mayor = space[x]
#     end
#   end
#   mayor 
# end

# Completando códigos postales faltantes y mayores a 5 dígitos
contents = CSV.open "../event_attendees.csv", headers: true, header_converters: :symbol 
contents.each do |row|
  name = row[:first_name]
  zip_code = row[:zipcode]

  # lo primero a tomar en cuenta son los códigos nulos 
  # si el código postal contiene 5 dígitos asumimos que esta bien
  # si el código postal contiene menos de 5 dígitos anteponemos ceros hasta completar 5 dígitos 
  # si el código postal contien más de 5 dígitos mostramos los 5 primeros dígitos 

  if zip_code.nil? 
    zip_code = "0"*5
  elsif zip_code.length < 5
    zip_code = zip_code.rjust(5, "0")
  elsif zip_code.length > 5
    zip_code = zip_code[0, 4]
  end

  puts "Name: #{name.colorize(:yellow)} Zipcode: #{zip_code.colorize(:green)}"
end

# Limpiando el código moviendo zipcode a un méotdo 
def clean_zipcode(zip_code)
  if zip_code.nil? 
    zip_code = '0'*5
  elsif zip_code.size < 5 
    zip_code = zip_code.rjust(5, '0')
  elsif zip_code.size > 5
    zip_code = zip_code[0, 4]
  else 
    zip_code 
  end
end

# def clean_zipcode(zip_code)
#   zip_code.to_s.rjust(5, "0")[0, 4]
# end

contents = CSV.open "../event_attendees.csv", headers: true, header_converters: :symbol 
contents.each do |row|
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])

  puts "Name: #{name.colorize(:cyan)}, Zipcode: #{zipcode.colorize(:light_red)}"
end

# Refactorizando método clean_zipcode() 
nil_to_string = <<-HEREDOC

  Usando otro enfoque para limpiar el método cuando: 
  - Si el valor es núlo en lugar de verificar si es .nil? 
    convertimos el valor nulo en una cadena con to_s.
  - Agregando dígitos cuando la longitud de zipcode es menor
    a cinco dígitos rjust(5, '0')
  - Truncando la cadena si la longitud de la cadena es mayor
    a cico dígitos rjust[0, 4]
  - Estos métodos pueden ser encadenados en una sola línea
    para limpiar el método clean_zipcode.
   
    def clean_zipcode(zip_code)
      zip_code.to_s.rjust(5, "0")[0, 4]
    end

HEREDOC
puts nil_to_string.colorize(:yellow)