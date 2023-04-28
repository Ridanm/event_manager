require 'csv'
require 'google/apis/civicinfo_v2'

puts "\n\nCreando carta de agradecimiento y lista de representantes: "


def clean_zipcode(zip)
  zip.to_s.rjust(5, '0')[0, 4]
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin    
    legislators = civic_info.representative_info_by_address(
      address: zip,
      leverls: 'country',
      roles: ['legislatorUpperBody', 'legislatorsLowerBody']
    )

    legislators = legislators.officials
    legislators_names = legislators.map(&:name)
    legislators_string = legislators_names.join(', ')
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

template_letter = File.read('../form_letter.html')

contents = CSV.open '../event_attendees.csv', headers: true, header_converters: :symbol 

contents.each do |row|
  name = row[:first_name]
  zip_code = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zip_code)

  personal_letter = template_letter.gsub('FIRST_NAME', name)
  personl_letter = template_letter.gsub!('LEGISLATORS', legislators)

  puts personal_letter 
end