class Skill
  include DataMapper::Resource

  property :id, Serial
  property :type_id, Integer, required: true
  property :name, String
  property :description, String
  property :market_group_id, Integer
  property :group_id, Integer
  property :icon_id, Integer
  property :published, Boolean

  validates_uniqueness_of :type_id

end