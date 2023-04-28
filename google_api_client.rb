# Mostrando los legisladores en un código postal
# Establecer clave api 
# Envía la consulta con lod criterios dados
# Analice la respouesta para los nombres de sus legisladores 

# Explorando datos 
require 'csv'
require 'google/apis/civicinfo_v2'

puts 'EventManager initialized.'

civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

# contents = CSV.open(
#   '../event_attendees.csv',
#   headers: true,
#   header_converters: :symbol
# )

# contents.each do |row|
#   name = row[:first_name]

#   zipcode = clean_zipcode(row[:zipcode])

#   begin
#     legislators = civic_info.representative_info_by_address(
#       address: zipcode,
#       levels: 'country',
#       roles: ['legislatorUpperBody', 'legislatorLowerBody']
#     )
#     legislators = legislators.officials
#   rescue
#     'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
#   end

#   #puts "#{name} #{zipcode} #{legislators}"
# end


# Recopilación de los nombres de los legisladores 
# Para código postal, repita la matriz de legisladores
# Para cada legislador, queremos encontrar el nombre del representante
# Agregue el nombre a una nueva colección de nombres

puts "\n\nObteniendo el nombre de los legisladores."

contents = CSV.open "../event_attendees.csv", headers: true, header_converters: :symbol 

contents.each do |row|
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  begin   
    legislators = civic_info.representative_info_by_address(
      address: zipcode,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    )
    legislators = legislators.officials 
    legislators_names = legislators.map(&:name)
  rescue 
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end

  puts "#{name} #{zipcode} #{legislators_names}"
end


puts "\n\nPasando los nombres de las matrices a cadena: "

contents = CSV.open(
  '../event_attendees.csv', 
  headers: true, 
  header_converters: :symbol 
)

contents.each do |row|
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  begin   
    legislators = civic_info.representative_info_by_address(
      address: zipcode, 
      levels: 'country', 
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    )
    legislator = legislators.officials
    legislator_names = legislator.map(&:name)
    legislator_string = legislator_names.join(', ')
  rescue 
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end

  puts "#{name} #{zipcode} #{legislator_string}"
end


puts "\n\nMoviendo la visualización de los legisladores a un método: "

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new 
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    legislators = civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    )
    legislators = legislators.officials 
    legislators_names = legislators.map(&:name)
    legislators_string = legislators_names.join(", ")
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

contents = CSV.open(
  '../event_attendees.csv',
  headers: true, 
  header_converters: :symbol
)

contents.each do |row|
  name = row[:first_name]
  zip_code = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zip_code)

  puts "#{name} #{zip_code} #{legislators}"
end
