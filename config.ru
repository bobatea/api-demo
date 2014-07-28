require 'bundler/setup'
require 'sinatra'
require 'mongoid'
require 'autoinc'
require 'json'

Dir["./models/*.rb"].each {|file| require file }
require './app'

Mongoid.load!("./config/mongoid.yml")

set :run, false
set :raise_errors, true

run Sinatra::Application