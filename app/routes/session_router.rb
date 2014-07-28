#
# session controller
#

class BobaAPI < Sinatra::Base
  post "/login", provides: :json do
    content_type :json

    user = User.find_by(username: params[:username]) rescue nil

    if user && user.authenticate(params[:password])
      user.to_a.to_json
    else
      {failure: "login error"}.to_json
    end
  end
end