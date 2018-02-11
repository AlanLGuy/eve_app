  class IndustryActivityProduct
    include DataMapper::Resource

    property :type_id, Integer, key: true
    property :activity_id, Integer, key: true
    property :product_type_id, Integer, key: true
    property :quantity, Integer

    belongs_to :industry_blueprint, {primary_key: :type_id, child_key: :type_id}
    has 1, :inv_type, {primary_key: :product_type_id, child_key: :type_id}
  end
