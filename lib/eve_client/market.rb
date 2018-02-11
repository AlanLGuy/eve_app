module EveClient
  class Market < ESI
    class << self
      def get_history(region_id, type_id)
        get("/markets/#{region_id}/history/?type_id=#{type_id}")
      end

      def get_prices
        get("/markets/prices/")
      end

    end
  end
end