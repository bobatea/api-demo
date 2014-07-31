def authenticate!
  str = request.env["HTTP_ACCESS_TOKEN"]
  Token.find_by(access_token: str) rescue nil
end