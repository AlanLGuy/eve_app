class ConnectionError < StandardError
  attr_reader :response

  def initialize(msg = "Error connecting to Eve Service", response)
    puts response
    @response = response
    super(msg)
  end
end

module EveClient
  class ESI

    class << self

      attr_accessor :access_token

      BASE_URL = "https://esi.tech.ccp.is/latest"
      PUBLIC_RESOURCES = [/\/characters\/\d*\/stats\//]

      def header
        {Authorization: "Bearer #{Session.access_token}"}
      end

      def get(resource)

        if public?(resource)
          response = RestClient.get("#{BASE_URL}#{resource}")
        else
          response = RestClient.get("#{BASE_URL}#{resource}", header)
        end

        if response.code == 200
          JSON(response.body)
        else
          begin
            raise(ConnectionError, response)
          rescue => e
            puts e.response
          end
        end

      end

      def public?(resource)
        PUBLIC_RESOURCES.any? {|url| resource.match?(url)}
      end

    end
  end
end
