require 'singleton'
class Config
  include Singleton
  class << self
    attr_accessor :redirect_uri, :client_id, :client_secret, :scope, :state
  end
end