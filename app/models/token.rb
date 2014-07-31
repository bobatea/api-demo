class Token
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  belongs_to :user, class_name: "User"
  before_create :generate_access_token

  field :access_token, type: String

  private
    def generate_access_token
      self.access_token = SecureRandom.uuid
    end

end