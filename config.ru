root = ::File.dirname(__FILE__)
require ::File.join( root, 'application' )

# Grape server
use Rack::Session::Pool,
          :expire_after => 60      # 3 mins
run Rack::Cascade.new [PicPic, PicPicAPI]