#
# User controller
#
class PicPicAPI < Grape::API

  namespace :protected do

    # Auth
    before do
      error!('Unauthorized', 401) unless authenticate!
    end

    # index
    get "/users" do

      if users = User.all
        users.to_a
      else
        halt 404
      end
    end

    # self
    get "/user/profile" do

      user = @token.user rescue nil
      if user
        user
      else
        {
          error: "user not found",
          messages: "user not found"
        }
      end
    end

    # find
    get "/user/:id" do

      user = User.find_by(user_id: params[:id].to_i) rescue nil
      if user
        user
      else
        {
          error: "user not found",
          messages: "user not found"
        }
      end
    end

    # # delete
    # delete '/user/:id' do

    #   user = User.find_by(user_id: params[:id].to_i) rescue nil

    #   if user && user.destroy!
    #     {success: "user deleted"}
    #   else
    #     {
    #       error: "deleting error",
    #       messages: "deleting error"
    #     }
    #   end
    # end
  end
end