require 'base64'

module EveClient
  class Authorization

    class << self

      VERIFICATION_URL = 'https://login.eveonline.com/oauth/verify'
      AUTHORIZATION_URL = 'https://login.eveonline.com/oauth/token'

      def login_url
        parameters = "?response_type=code&redirect_uri=#{Config.redirect_uri}&client_id=#{Config.client_id}&scope=#{Config.scope}&state=#{Config.state}"
        "https://login.eveonline.com/oauth/authorize/#{parameters}"
      end

      def authorize(authorization_code)
        header = {:Authorization => "Basic #{Base64.strict_encode64(Config.client_id + ":" + Config.client_secret)}"}

        params = {:grant_type => "authorization_code", :code => authorization_code}
        response = JSON(RestClient.post(AUTHORIZATION_URL, params, header).body)
        access_token = response["access_token"]
        refresh_token = response["refresh_token"]
        [access_token, refresh_token]
      end

      def verify
        response = RestClient.get(VERIFICATION_URL, {Authorization: "Bearer #{Session.access_token} "})
        if response.code == 200
          JSON(response.body)["CharacterID"]
        else
          raise(" Error during verification ")
        end
      end

    end
  end
end
