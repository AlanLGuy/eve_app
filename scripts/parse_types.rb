require 'rest_client'
require 'yaml'
require 'json'

#Get a list of all EVE Types

response = RestClient.get("https://esi.tech.ccp.is/latest/universe/types/")

type_hash = []
if response.code == 200
  puts 'retrieving types'
  types = []
  max_pages = response.headers[:x_pages].to_i
  current_page = 1

  max_pages.times do
    response = RestClient.get("https://esi.tech.ccp.is/latest/universe/types/?page=#{current_page}")
    types.concat(JSON(response.body))
    current_page+=1
  end

  total_records = types.count.to_f
  current_record  = 0.0
  types.each do |type_code|
    current_record+=1.0
    puts "#{((current_record/total_records) * 100).to_i}%"
    response = RestClient.get("https://esi.tech.ccp.is/latest/universe/types/#{type_code}/")
    type_hash << JSON(response.body)
  end
else
  raise("Problem Connecting to EVE services, code was #{response.code}\nresponse:#{response}")
end

puts 'writing output file'
File.open(File.expand_path('../../data/types.yaml', __FILE__), 'w') do |file|
  file.puts type_hash.to_yaml
end
