
# User controller

# index
get "/users" do
  content_type :json

  if users = User.all
    users.to_a.to_json
  else
    json_status 404, "Not found"
  end
end

# create
post '/user', provides: :json do
  content_type :json

  user = User.new(:username => params[:username],
                  :password => params[:password])

  if user.save
    user.to_json
  else
    {failure: "creating error"}.to_json
  end
end

# find
get "/user/:id" do
  content_type :json

  user = User.find_by(user_id: params[:id].to_i) rescue nil
  if user
    user.to_a.to_json
  else
    {failure: "finding error"}.to_json
  end
end

# delete
get '/user/:id/delete' do
  content_type :json

  user = User.find_by(user_id: params[:id].to_i) rescue nil

  if user.destroy
    {:success => "ok"}.to_json
  else
    {failure: "deleting error"}.to_json
  end
end

# session controller
post "/login", provides: :json do
  content_type :json

  user = User.find_by(username: params[:username]) rescue nil

  if user.authenticate(params[:password])
    user.to_a.to_json
  else
    {failure: "login error"}.to_json
  end
end
