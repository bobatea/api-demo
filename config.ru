root = ::File.dirname(__FILE__)
require ::File.join( root, 'application' )

# Grape server
run Rack::URLMap.new("/" => PicPic.new,
                     "/api" => PicPicAPI.new)