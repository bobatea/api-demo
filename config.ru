root = ::File.dirname(__FILE__)
require ::File.join( root, 'application' )

I18n.enforce_available_locales = false

# Grape server
use Rack::Session::Pool,
          :expire_after => 60 * 3      # 3 mins
run Rack::Cascade.new [PicPic, PicPicAPI]