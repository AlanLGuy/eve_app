$: << File.dirname(__FILE__)
require 'rubygems'
require 'bundler/setup'
require 'eve_app'

use EveApp::Application
run Sinatra::Application
