class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :pic

  field :text, type: String

  validates :text,  presence: true, length: { minimum: 1 }

end