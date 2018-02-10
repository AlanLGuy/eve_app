require 'sinatra/base'
require 'haml'
require 'yaml'
require 'data_mapper'
require 'lib/controllers'
require 'lib/config'
require 'lib/session'
require 'lib/eve_client'

require 'models/model'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")
DataMapper.finalize


module EveApp
  class << self
    attr_accessor :config
  end

  class Application < Sinatra::Base

    before do
      Session.access_token = session[:access_token]
    end

    configure do
      enable :sessions
    end

    configure :production do
      Config.scope = 'esi-skills.read_skills.v1 esi-skills.read_skillqueue.v1 esi-wallet.read_character_wallet.v1 esi-assets.read_assets.v1 esi-planets.manage_planets.v1 esi-markets.structure_markets.v1 esi-characters.read_standings.v1 esi-characters.read_agents_research.v1 esi-industry.read_character_jobs.v1 esi-markets.read_character_orders.v1 esi-characters.read_blueprints.v1 esi-contracts.read_character_contracts.v1 esi-wallet.read_corporation_wallets.v1 esi-industry.read_corporation_jobs.v1 esi-industry.read_character_mining.v1'
      Config.state = 'thatsanicestateyouhavethere'
      Config.redirect_uri = 'https://thawing-hollows-77046.herokuapp.com/authorized'
      Config.client_id = ENV['CLIENT_ID']
      Config.client_secret = ENV['CLIENT_SECRET']
    end

    configure :local do
      private_data = YAML.load_file('config/private.yaml')
      Config.redirect_uri = 'http://localhost:7272/authorized'
      Config.client_id = private_data[:CLIENT_ID]
      Config.client_secret = private_data[:CLIENT_SECRET]
      Config.scope = 'esi-skills.read_skills.v1 esi-skills.read_skillqueue.v1 esi-wallet.read_character_wallet.v1 esi-assets.read_assets.v1 esi-planets.manage_planets.v1 esi-markets.structure_markets.v1 esi-characters.read_standings.v1 esi-characters.read_agents_research.v1 esi-industry.read_character_jobs.v1 esi-markets.read_character_orders.v1 esi-characters.read_blueprints.v1 esi-contracts.read_character_contracts.v1 esi-wallet.read_corporation_wallets.v1 esi-industry.read_corporation_jobs.v1 esi-industry.read_character_mining.v1'
      Config.state = 'thatsanicestateyouhavethere'

      set :port, 7272
      set :reload_templates, true
      set :public_folder, 'public'
    end

    set :haml, :format => :html5

    get '/authorized' do
      authorization_code = @params['code']
      session[:access_token], session[:refresh_token] = EveClient::Authorization.authorize(authorization_code)
      Session.access_token = session[:access_token]
      session[:character_id] = EveClient::Authorization.verify
      redirect('index')
    end

    get '/' do
      redirect('index')
    end

    get '/login' do
      redirect(EveClient::Authorization.login_url)
    end

    get '/index' do
      if session[:access_token]
        @log = []
        @character = Character.new(session[:character_id])
      end
      haml :index
    end

  end
end