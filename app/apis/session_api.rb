#
# session controller
#

class PicPicAPI < Grape::API
  post "/signin" do

    user = User.find_by(username: params[:username]) rescue nil

    if user && user.authenticate(params[:password])
      # if no token create one
      user.token = Token.create! unless user.token
      {
        success: true,
        info: {
          username: user.username,
          user_id: user.user_id,
          gender: user.gender,
          token: user.token.access_token
        }
      }
    else
      {
        success: false,
        messages: "signin error"
      }
    end
  end


  # create
  post '/signup', provides: :json do

    user = User.new(:username => params[:username],
                    :password => params[:password],
                    :gender => params[:gender])

    if user.save
      user.token = Token.create!
      {
        success: true,
        info: {
          username: user.username,
          user_id: user.user_id,
          gender: user.gender,
          token: user.token.access_token
        }
      }
    else
      {
        success: false,
        messages: user.errors.messages
      }
    end
  end

  namespace :protected do

    # Auth
    before do
      error!('Unauthorized', 401) unless authenticate!
    end

    get '/signout' do
      str = request.env["HTTP_ACCESS_TOKEN"]
      token = Token.find_by(access_token: str) rescue nil
      if token && token.destroy!
        {
          success: true,
          info: "signout success"
        }
      else
        {
          success: false,
          info: "signout error"
        }
      end
    end

  end

end
