class Pic
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Autoinc

  field :pic_id, type: Integer
  field :s3_filename, type: String
  field :url, type: String
  field :description, type: String

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  # increased id
  increments :pic_id

  # url must present
  validates :s3_filename, presence: true
  validates :url,  presence: true

end