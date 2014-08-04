root = ::File.dirname(__FILE__)
require ::File.join( root, 'application' )

require 'goliath'
require 'em-synchrony'

# Goliath as asynchronous Server
class PicPicAPIServer < Goliath::API

  def response(env)
    PicPicAPI.call(env)
  end

end