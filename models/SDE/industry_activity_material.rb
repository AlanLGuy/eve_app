  class IndustryActivityMaterial
    include DataMapper::Resource

    property :type_id, Integer, key: true
    property :activity_id, Integer, key: true
    property :material_type_id, Integer, key: true
    property :quantity, Integer

    belongs_to :industry_blueprint, {parent_key: :type_id, child_key: :type_id}
    # has n, :industry_blueprint, {parent_key: :type_id, child_key: :type_id}
    has n, :inv_type, {parent_key: :material_type_id, child_key: :type_id}
  end
