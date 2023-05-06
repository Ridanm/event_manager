# Tarea: números de teléfonos limpios
# 1- Si el número de teléfono tiene menos de 10 dígitos, suponga que es un número incorrecto
# 2- Si el número de teléfono tiene 10 números, suponga que es correcto
# 3- Si el número de teléfono tiene 11 dígitos y el primer número es 1, recorte el 1 y use lo 10 dígitos restantes
# 4- Si el número de teléfono tiene 11 dígitos y el primer número no es 1, entonces es un número incorrecto
# 5- Si el número de teléfono tiene más de 11 dígitos, suponga que es un número incorrecto 
require 'csv'
require 'colorize'

def validate_phone_numbers(phone)
  numbers = ''
  
  phone.each_char do |num|
    if num.between?('0', '9')
      numbers << num
    end
  end
  
  if numbers.size < 10 # 1
    puts 'Wrong phone number'
  elsif numbers.size == 10 # 2
    puts 'The phone number is correct'
    puts "(#{numbers[0..2]}) #{numbers[3..5]}-#{numbers[6..10]}"
  elsif numbers.size == 11 && numbers[0] == '1' # 3
    puts 'Starts with 1'
    puts "(#{numbers[1..3]}) #{numbers[4..6]}-#{numbers[7..11]}"
  elsif numbers.size == 11 && numbers[0] != '1' # 4
    puts 'Wrong phone number 11 digits does not start with 1'
  elsif numbers.size > 11 # 5 
    puts 'Wrong phone number more than 11 digits'
  end
end



def correct_phone(phone)
  numbers = '' 

  phone.each_char { |num| numbers << num if num.between?('0', '9')}

  if numbers.size == 10
    print 'Correct numbers: '.colorize(:green)
    puts "(#{numbers[0..2]}) #{numbers[3..5]}-#{numbers[6..10]}"
  elsif numbers.size == 11 && numbers[0] == '1'
    print 'Correct numbers: '.colorize(:yellow)
    puts "(#{numbers[1..3]}) #{numbers[4..6]}-#{numbers[7..11]}"
  end
end

puts "\nThe Phone numbers that have been entered correctly\n".colorize(:green)

contents = CSV.open(
  '../event_attendees.csv', 
  headers: true,
  header_converters: :symbol 
)

contents.each do |row|
  puts correct_phone(row[:homephone])
end