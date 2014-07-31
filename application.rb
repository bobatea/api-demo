#
#  all requirements
#
require 'sinatra/base'
require 'sinatra/namespace'
require 'json'
require 'securerandom'
require 'mongoid'
require 'autoinc'

class BobaAPI < Sinatra::Base
  register Sinatra::Namespace
  enable :session

  configure :production do
    set :clean_trace, true
    set :dump_errors, false
  end

  configure :development do
    set :raise_errors, true
  end

  # welcome
  get '/' do
    {
      message: "welcome to BobaAPI"
    }.to_json
  end

  # Auth
  before '/protected/*' do
    token = authenticate!
    error 401 unless token
  end

  # 404
  not_found do
    content_type :json
    {error: "404 !", messages: "Not found."}.to_json
  end

  # 401
  error 401 do
    content_type :json
    {
      error: "401",
      messages: "Unauthorization error"
    }.to_json
  end

  # general error handle
  error 500 do
    content_type :json
    {
      error: "500",
      messages: "Inner error"
    }.to_json
  end

end

# load app files
Dir["./app/*/*.rb"].each {|file| require file }

# Mongoid config
Mongoid.load!("./config/mongoid.yml")
# config.oauth.database = Mongo::Connection.new(mongoid_config['host'], mongoid_config['port']).db(mongoid_config['database'])