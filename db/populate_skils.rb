require 'data_mapper'
require_relative '../models/model'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{File.expand_path('../../', __FILE__)}/development.db")
DataMapper.finalize

Skill.all.destroy

skills = YAML.load_file(File.expand_path('../data/skills.yaml'))
skills.each do |skill|
  Skill.first_or_create({:type_id => skill['type_id'].to_i}, {:type_id => skill['type_id'].to_i,
                                                                      :name => skill['name'],
                                                                      :group_id => skill['group_id'].to_i,
                                                                      :icon_id => skill['graphic_id'].to_i,
                                                                      :market_group_id => skill['market_group_id'].to_i,
                                                                      :published => skill['published'] == true})
end