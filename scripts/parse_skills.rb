require 'yaml'
require 'rest-client'
require 'json'

categories = YAML.load_file(File.expand_path('../../data/categories.yaml', __FILE__))
groups = YAML.load_file(File.expand_path('../../data/groups.yaml', __FILE__))

skill_category_id = categories.find {|category| category['name'] == "Skill"}['category_id']
type_codes = groups.select {|group| group['category_id'] == skill_category_id}.map {|group| group['types']}.flatten

skills = []
type_codes.each do |type|
  skill =  JSON(RestClient.get("https://esi.tech.ccp.is/latest/universe/types/#{type}/").body)
  skills << skill
end

File.open(File.expand_path('../../data/skills.yaml', __FILE__), 'w') do |file|
  file.puts skills.to_yaml
end
