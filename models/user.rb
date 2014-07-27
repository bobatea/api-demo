class User
  include Mongoid::Document
  field :username
  field :password

  def self.authenticate(username, password)
      u = User.where(:username => username).first
      return nil if u.nil?
      return u if Digest::MD5.hexdigest(password) == u.password
  end
end