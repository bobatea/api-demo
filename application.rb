#
#  all requirements
#
require 'sinatra/base'
require 'sinatra/namespace'
require 'grape'
require 'json'
require 'securerandom'
require 'mongoid'
require 'autoinc'
require 'yaml'
require 'aws-sdk'

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

  get :session do
    session
  end

  get :set do
    session[:id] = params[:id]
  end

end


# load app files
Dir["./app/*/*.rb"].each {|file| require file }

# config
# Mongoid config
Mongoid.load!('./config/mongoid.yml')

# AWS config
_aws = YAML.load(File.read('./config/aws.yml'))
AWS.config(
  :access_key_id     => _aws['AWS_ACCESS_KEY_ID'],
  :secret_access_key => _aws['AWS_SECRET_ACCESS_KEY']
)

# S3 univeral variable
_S3 = AWS::S3.new( :region => "us-east-1" )
_S3.buckets.create 'picpic.img' if _S3.buckets['picpic.img']
$Bucket = _S3.buckets['picpic.img']