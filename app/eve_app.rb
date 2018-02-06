require 'rest-client'
require 'launchy'
require 'rack'
require 'sinatra/base'
require 'base64'
require 'haml'
require 'yaml'
require_relative 'lib/character'


if File.exist?(File.expand_path('../config/private.yaml', __FILE__))
  private_data = YAML.load_file('app/config/private.yaml')
  CLIENT_ID = private_data[:CLIENT_ID]
  CLIENT_SECRET = private_data[:CLIENT_SECRET]
else
  CLIENT_ID = ENV['CLIENT_ID']
  CLIENT_SECRET = ENV['CLIENT_SECRET']
end

REDIRECT_URI = 'https://thawing-hollows-77046.herokuapp.com/authorized'
SCOPE = 'esi-skills.read_skills.v1 esi-skills.read_skillqueue.v1 esi-wallet.read_character_wallet.v1 esi-assets.read_assets.v1 esi-planets.manage_planets.v1 esi-markets.structure_markets.v1 esi-characters.read_standings.v1 esi-characters.read_agents_research.v1 esi-industry.read_character_jobs.v1 esi-markets.read_character_orders.v1 esi-characters.read_blueprints.v1 esi-contracts.read_character_contracts.v1 esi-wallet.read_corporation_wallets.v1 esi-industry.read_corporation_jobs.v1 esi-industry.read_character_mining.v1'
STATE = 'thatsanicestateyouhavethere'

class EveApp < Sinatra::Base
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

  get '/'do
    parameters = "?response_type=code&redirect_uri=#{REDIRECT_URI}&client_id=#{CLIENT_ID}&scope=#{SCOPE}&state=#{STATE}"
    puts parameters

    if session[:access_token]
      redirect('index')
    else
      redirect("https://login.eveonline.com/oauth/authorize/#{parameters}")
    end
  end

  get '/index' do
    @log = []
    @character = Character.new(session[:access_token])

    haml :index
  end

end
# Launchy.open()
