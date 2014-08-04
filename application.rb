#
#  all requirements
#
require 'sinatra/base'
require 'sinatra/namespace'
require 'goliath'
require 'grape'
require 'json'
require 'securerandom'
require 'mongoid'
require 'em-synchrony'
require 'autoinc'

# Sinatra as Front-End
class PicPic < Sinatra::Base
  register Sinatra::Namespace

  configure :production do
    set :clean_trace, true
    set :dump_errors, false
  end

  configure :development do
    set :raise_errors, true
  end

  # welcome
  get '/' do
    "welcome to PicPic-FrontEnd"
  end

end


# Grape as API
class PicPicAPI < Grape::API

  prefix 'api'
  version 'v1', :using => :path
  format :json

  get do
    {
      message: "welcome to PicPic-API"
    }
  end

end


# load app files
Dir["./app/*/*.rb"].each {|file| require file }

# Mongoid config
Mongoid.load!("./config/mongoid.yml")