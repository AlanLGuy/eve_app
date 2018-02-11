class FuzzWorksAPI


  def get_market_data(region, types)
    items = types.split(',')

    url = "https://market.fuzzwork.co.uk/aggregates/?region=#{region}&types=#{items}"

    begin
      response = RestClient.get(url)

      if response.code == 200
        JSON(response.body)
      else
        begin
          raise(ConnectionError, response)
        rescue => e
          puts e.response
        end
      end
    rescue => e
      puts url
      puts e.message
    end
  end

end