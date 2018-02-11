require 'data_mapper'
require 'progress_bar'

require_relative '../models/model'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{File.expand_path('../../', __FILE__)}/development.db")
DataMapper.finalize

Skill.all.destroy
puts 'Loading input file'
skills = YAML.load_file(File.expand_path('../data/skills.yaml'))
bar = ProgressBar.new(skills.count)
puts 'Populating table'
skills.each_with_index do |skill|
  bar.increment!

  Skill.first_or_create({:type_id => skill['type_id'].to_i}, {:type_id => skill['type_id'].to_i,
                                                                      :name => skill['name'],
                                                                      :group_id => skill['group_id'].to_i,
                                                                      :icon_id => skill['graphic_id'].to_i,
                                                                      :market_group_id => skill['market_group_id'].to_i,
                                                                      :published => skill['published'] == true})
end