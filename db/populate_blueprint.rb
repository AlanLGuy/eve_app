require 'data_mapper'
require_relative '../models/model'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{File.expand_path('../../', __FILE__)}/development.db")
DataMapper.finalize

Blueprint.all.destroy
blueprints = YAML.load_file(File.expand_path('../data/blueprints.yaml'))
blueprints.each do |blueprint|
  Blueprint.first_or_create({:type_id => blueprint['type_id'].to_i}, {:type_id => blueprint['type_id'].to_i,
                                                                      :name => blueprint['name'],
                                                                      :group_id => blueprint['group_id'].to_i,
                                                                      :icon_id => blueprint['graphic_id'].to_i,
                                                                      :market_group_id => blueprint['market_group_id'].to_i,
                                                                      :published => blueprint['published'] == true})
end