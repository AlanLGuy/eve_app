require 'rest_client'
require 'yaml'
require 'json'

#Get a list of all EVE Categories
#
response = RestClient.get("https://esi.tech.ccp.is/latest/universe/categories/")

category_hash = []
if response.code == 200
  puts 'retreiving categories'
  categories = JSON(response.body)
  categories.each do |category_code|
    response = RestClient.get("https://esi.tech.ccp.is/latest/universe/categories/#{category_code}/")
    category_hash << JSON(response.body)
    puts "category:#{category_hash}"
  end
else
  raise("Problem Connecting to EVE services, code was #{response.code}\nresponse:#{response}")
end

puts 'writing output file'
File.open(File.expand_path('../../data/categories.yaml', __FILE__), 'w') do |file|
  file.puts category_hash.to_yaml
end

#
#
# response = RestClient.get("https://esi.tech.ccp.is/latest/universe/categories/16/", {Authorization: "Bearer #{@access_token}"})
# puts JSON(response.body)['groups']
