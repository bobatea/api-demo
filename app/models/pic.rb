class Pic
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Autoinc

  field :pic_id, type: Integer
  field :url, type: String
  field :description, type: String

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  # increased id
  increments :pic_id

  # url must present
  validates :url,  presence: true

end