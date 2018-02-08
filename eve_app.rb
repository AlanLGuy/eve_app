require 'rest-client'
require 'base64'
require 'haml'
require 'sinatra/base'

require_relative 'lib/character'

class EveApp < Sinatra::Application

  set :haml, :format => :html5
  enable :sessions

  get '/authorized' do
    $authorization_code = @params['code']
    $client_state = @params['state']

    header = {:Authorization => "Basic #{Base64.strict_encode64(CLIENT_ID + ":" + CLIENT_SECRET)}"}
    params = {:grant_type => "authorization_code", :code => $authorization_code}
    response = JSON(RestClient.post('https://login.eveonline.com/oauth/token', params, header).body)

    session[:access_token] = response["access_token"]
    session[:refresh_token] = response["refresh_token"]

    redirect('index')
  end

  get '/' do
    parameters = "?response_type=code&redirect_uri=#{REDIRECT_URI}&client_id=#{CLIENT_ID}&scope=#{SCOPE}&state=#{STATE}"

    if session[:access_token]
      redirect('index')
    else
      redirect("https://login.eveonline.com/oauth/authorize/#{parameters}")
    end
  end

  get '/index' do
    unless session[:access_token]
      parameters = "?response_type=code&redirect_uri=#{REDIRECT_URI}&client_id=#{CLIENT_ID}&scope=#{SCOPE}&state=#{STATE}"
      redirect("https://login.eveonline.com/oauth/authorize/#{parameters}")
    end
    @log = []
    @character = Character.new(session[:access_token])

    haml :index
  end

end
