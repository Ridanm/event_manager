# Tarea: números de teléfonos limpios
# 1- Si el número de teléfono tiene menos de 10 dígitos, suponga que es un número incorrecto
# 2- Si el número de teléfono tiene 11 dígitos y el primer número es 1, recorte el 1 y use lo 10 dígitos restantes
# 3- Si el número de teléfono tiene 11 dígitos y el primer número no es 1, entonces es un número incorrecto
# 4- Si el número de teléfono tiene más de 11 dígitos, suponga que es un número incorrecto 
require 'csv'

def format_phone_numbers(phone)
  if phone.size < 10 # 1
    puts 'Incorrect phone number'
  elsif phone.size == 11 && phone[0] == '1' # 2
    puts 'Comienza con 1'
    puts phone[0]
    puts phone[1..11]
  elsif phone.size == 10 && phone[0] != '1' # 3
    puts 'No comienza con 1'
  elsif phone.size > 11 # 4
    puts 'El número no es correcto mas de 11 dígitos'
  end
end

contents = CSV.open(
  '../event_attendees.csv', 
  headers: true,
  header_converters: :symbol 
)

contents.each do |row|
  puts row[:homephone]
  puts format_phone_numbers(row[:homephone])
end