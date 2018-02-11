  class IndustryBlueprint
    include DataMapper::Resource

    property :type_id, Integer, key: true
    property :max_production_limit, Integer

    has 1, :inv_type, {parent_key: :type_id, child_key: :type_id}
    has n, :industry_activity_products, {parent_key: :type_id, child_key: :type_id}
    has n, :industry_activity_materials, {parent_key: :type_id, child_key: :type_id}
    # has n, :materials, through: :industry_activity_materials
  end
