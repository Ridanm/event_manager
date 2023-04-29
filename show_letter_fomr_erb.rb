require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb' 

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, "0")[0..4]
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip, 
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue 
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

puts "EventManager Initialized."

contents = CSV.open(
  "../event_attendees.csv",
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('../letter_form.erb')
erb_template = ERB.new(template_letter)

contents.each do |row|
  name = row[:first_name]
  zip_code = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zip_code)

  form_letter = erb_template.result(binding)
  puts form_letter
end


# Asigne una identificaciónn para el asistente
# Crear una carpeta de salida 
# Guarde cada carta modelo en un archivo basado en la identificaciónn del asistente
# Esto puede ser mediante el uso del número identificador de la primera fila 
puts "\n\nEnvio de cartas modelo a un archivo: "
contents = CSV.open(
  '../event_attendees.csv', 
  headers: true,
  header_converters: :symbol
)

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zip_code = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zip_code)
  
  form_letter = erb_template.result(binding)
  Dir.mkdir('output') unless Dir.exist?('output')
  filename = "output/thanks_#{id}.html"
  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end