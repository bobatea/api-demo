
get "/users", provides: :json do
  content_type :json

  if users = User.all
    users.to_a.to_json
  else
    json_status 404, "Not found"
  end
end


post '/user', provides: :json do
  content_type :json

  user = User.new(:username => params[:username],
                  :password => params[:password])

  if user.save
    user.to_json
  else
  end
end

