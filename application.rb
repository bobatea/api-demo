#
#  all requirements
#
require 'sinatra/base'
require 'json'
require 'mongoid'
require 'autoinc'

class BobaAPI < Sinatra::Base
  use Rack::Session::Pool, :expire_after => 2592000
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
    content_type :json
    {message: "welcome to BobaAPI"}.to_json
  end

  get '/about' do
    content_type :json
    {message: ""}.to_json
  end

  # 404
  not_found do
    content_type :json
    {error: "404 !", messages: "Not found."}.to_json
  end

  # general error handle
  error 400..500 do
    content_type :json
    {
      error: "Boom !",
      messages: "An error ocurred."
    }.to_json
  end

end

# load app files
Dir["./app/*/*.rb"].each {|file| require file }

# Mongoid config
Mongoid.load!("./config/mongoid.yml")

# all ENV