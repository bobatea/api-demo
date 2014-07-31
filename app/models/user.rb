class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Autoinc
  include ActiveModel::SecurePassword

  field :user_id, type: Integer
  field :username, type: String
  field :password_digest, type: String
  has_one :token, class_name: "Token", dependent: :delete

  # increased id
  increments :user_id

  # username
  validates :username,  presence: true, length: { maximum: 50 }

  # password
  validates_presence_of :password, :on => :create
  has_secure_password validations: false
  validates :password, length: { minimum: 6 }

end