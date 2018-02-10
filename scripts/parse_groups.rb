require 'rest_client'
require 'yaml'
require 'json'

#Get a list of all EVE Groups
#
response = RestClient.get("https://esi.tech.ccp.is/latest/universe/groups/")


group_hash = []
if response.code == 200
  groups = []
  max_pages = response.headers[:x_pages].to_i
  current_page = 1

  max_pages.times do
    response = RestClient.get("https://esi.tech.ccp.is/latest/universe/groups/?page=#{current_page}")
    groups.concat(JSON(response.body))
    current_page+=1
  end

  puts 'retrieving groups'
  total_records = groups.count.to_f
  current_record = 0.0
  groups.each do |group_code|
    current_record += 1.0
    puts "#{((current_record / total_records) * 100).to_i}%"
    response = RestClient.get("https://esi.tech.ccp.is/latest/universe/groups/#{group_code}/")
    group_hash << JSON(response.body)
  end
else
  raise("Problem Connecting to EVE services, code was #{response.code}\nresponse:#{response}")
end

puts 'writing output file'
File.open(File.expand_path('../../data/groups.yaml', __FILE__), 'w') do |file|
  file.puts group_hash.to_yaml
end
