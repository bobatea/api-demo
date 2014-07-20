require 'sinatra'
require 'json'

get '/sushi.json' do
  content_type :json
  return {:boba => ["我们", "的", "测试", "API", "哈哈哈"]}.to_json
end
