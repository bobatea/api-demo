def session
  env['rack.session']
end

def current_user
  @token.user rescue nil
end