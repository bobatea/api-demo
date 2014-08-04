root = ::File.dirname(__FILE__)
require ::File.join( root, 'application' )

# Grape server
run Rack::Cascade.new [PicPic, PicPicAPI]