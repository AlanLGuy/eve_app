  class InvType
    include DataMapper::Resource

    property :type_id, Integer, key: true
    property :group_id, Integer
    property :type_name, String
    property :description, String
    property :graphic_id, Integer
    property :icon_id, Integer
    property :market_group_id, Integer
    property :published, Boolean


    belongs_to :industry_blueprint
  end
