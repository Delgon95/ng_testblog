class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String
  field :abusive, type: Boolean, default: false

  validates_presence_of :body

  belongs_to :post
  belongs_to :user
  has_many :votes, dependent: :destroy

  def score
    votes.inject(0) { |sum, x| sum + x.value }
  end

  def negative_votes
    votes.where(value: -1)
  end
end
