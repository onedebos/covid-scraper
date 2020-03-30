require 'httparty'
require 'nokogiri'
require 'byebug'
require 'json'


def all_countries
  unparsed_page = HTTParty.get('https://www.worldometers.info/coronavirus/')
  parsed_page=Nokogiri::HTML(unparsed_page)
  records = []
  total_countries =  parsed_page.css("table#main_table_countries_today > tbody > tr").map(&:text).count
  i = 0
  while i < total_countries
    record = parsed_page.css("table#main_table_countries_today > tbody > tr[#{i}]").text
    record = record.split("\n")
    record_hash = {"name": record[1], "total_cases": record[2],"new_cases": record[3], "total_deaths": record[4],"new_deaths": record[5],"total_recovered": record[6],"active_cases": record[7],"first_case": record[8]}
    records << record_hash
    i+=1  
    
  end
 byebug
records
end

def find_country(country_to_find)
  down_country = country_to_find.downcase
  all_countries.select{ |country| country[:name].downcase == down_country }
end

puts find_country("nigeria")
