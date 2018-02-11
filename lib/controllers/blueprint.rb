module EveApp
  class Blueprint
    attr_accessor :type_id, :location_id, :location_flag, :quantity, :time_efficiency, :material_efficiency, :runs, :name, :icon

    def initialize(blueprint_data)
      blueprint_data.each_pair {|key, value| instance_variable_set("@#{key}", value)}
      @icon = "#{EveApp::IMAGE_SERVER}/Type/#{@type_id}_32.png"
    end

    def name
      IndustryBlueprint.first(type_id: @type_id).inv_type.type_name
    end

    def materials
      IndustryBlueprint.first(type_id: @type_id).industry_activity_materials.map {|material| Material.new(material.material_type_id, material.quantity)}
    end

    def total_cost
      cost = 0.0
      materials.each do |material|
        cost += (material.average_price * material.quantity)
      end
      cost
    end

    def product_cost
      # price_data = EveClient::Market.get_history(10000042, @type_id)
      product = IndustryBlueprint.first(type_id: @type_id).industry_activity_products.first({type_id: @type_id, activity_id: 1})
      prices = YAML.load_file(File.expand_path('../../../data/prices.yaml', __FILE__))
      latest_prices = prices[:data].find {|data| data['type_id'] == product.type_id}
      latest_prices['average_price']
    end

  end
end