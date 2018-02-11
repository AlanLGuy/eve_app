module EveApp
  class Material

    attr_accessor :type_id, :icon, :quantity, :average_price, :highest_price, :volume, :order_count

    def initialize(type_id, quantity)
      @type_id = type_id
      @quantity = quantity
      @icon = "#{EveApp::IMAGE_SERVER}/Type/#{@type_id}_32.png"
    end

    def name
      InvType.first(type_id: @type_id).type_name
    end

    #TODO Don't hardcode Metropolis
    def average_price
      populate_price_data unless @average_price
      @average_price
    end

    def populate_price_data
      # price_data = EveClient::Market.get_history(10000042, @type_id)
      prices = YAML.load_file(File.expand_path('../../../data/prices.yaml', __FILE__))
      latest_prices = prices[:data].find {|data| data['type_id'] == @type_id}
      @average_price = latest_prices['average_price']
    end

  end
end