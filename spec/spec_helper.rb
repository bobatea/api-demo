ENV["RACK_ENV"] ||= 'test'

require File.expand_path("../../application", __FILE__)
require 'rspec'
require 'rack/test'

I18n.enforce_available_locales = false

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.mock_with :rspec
  config.expect_with :rspec

  require 'database_cleaner'
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.orm = "mongoid"
  end
  config.before(:each) do
      DatabaseCleaner.clean
  end
end

# require 'capybara/rspec'
# Capybara.configure do |config|
#   config.app = PicPicAPI.new
#   config.server_port = 4567
# end