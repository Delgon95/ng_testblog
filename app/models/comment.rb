class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String

  validates_presence_of :body

  belongs_to :post
  belongs_to :user
end
