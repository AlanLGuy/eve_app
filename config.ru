require 'sinatra'
require 'rack'
require 'puma'
require 'yaml'

configure {set :server, :puma}


SCOPE = 'esi-skills.read_skills.v1 esi-skills.read_skillqueue.v1 esi-wallet.read_character_wallet.v1 esi-assets.read_assets.v1 esi-planets.manage_planets.v1 esi-markets.structure_markets.v1 esi-characters.read_standings.v1 esi-characters.read_agents_research.v1 esi-industry.read_character_jobs.v1 esi-markets.read_character_orders.v1 esi-characters.read_blueprints.v1 esi-contracts.read_character_contracts.v1 esi-wallet.read_corporation_wallets.v1 esi-industry.read_corporation_jobs.v1 esi-industry.read_character_mining.v1'
STATE = 'thatsanicestateyouhavethere'

if settings.environment == :local

  REDIRECT_URI = 'http://localhost:7272/authorized'
  private_data = YAML.load_file('config/private.yaml')
  CLIENT_ID = private_data[:CLIENT_ID]
  CLIENT_SECRET = private_data[:CLIENT_SECRET]

  configure do
    set :port, 7272
    set :reload_templates, true
  end

elsif settings.environment == :development
  REDIRECT_URI = 'https://thawing-hollows-77046.herokuapp.com/authorized'
  CLIENT_ID = ENV['CLIENT_ID']
  CLIENT_SECRET = ENV['CLIENT_SECRET']
else
  raise("Environment #{settings.environment} not configured")
end


require File.expand_path('eve_app', File.dirname(__FILE__))
EveApp.run!
