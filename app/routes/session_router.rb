#
# session controller
#

class BobaAPI < Sinatra::Base
  post "/login", provides: :json do
    content_type :json

    user = User.find_by(username: params[:username]) rescue nil

    if user && user.authenticate(params[:password])
      # if no token create one
      user.token = Token.create! unless user.token
      {
        success: true,
        info: user,
        token: user.token.access_token
      }.to_json
    else
      {
        success: false,
        messages: "login error"
      }.to_json
    end
  end


  # create
  post '/signup', provides: :json do
    content_type :json

    user = User.new(:username => params[:username],
                    :password => params[:password])

    if user.save
      token = Token.create!
      user.token = token
      {
        success: true,
        info: user,
        token: token
      }.to_json
    else
      {
        success: false,
        messages: user.errors.messages
      }.to_json
    end
  end

  namespace '/protected' do
    get '/signout' do
      content_type :json
      str = request.env["HTTP_ACCESS_TOKEN"]
      token = Token.find_by(access_token: str) rescue nil
      if token && token.destroy!
        {
          success: true,
          messages: "signout success"
        }.to_json
      else
        {
          success: false,
          messages: "signout error"
        }.to_json
      end
    end
  end
end
