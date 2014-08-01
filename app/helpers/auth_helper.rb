def authenticate!
  str = request.env["HTTP_ACCESS_TOKEN"]
  @token = Token.find_by(access_token: str) rescue nil
end