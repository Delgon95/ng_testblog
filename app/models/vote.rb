class Vote
  include Mongoid::Document
  include Mongoid::Timestamps

  field :value, type: Integer

  after_create :update_comment_abusive

  belongs_to :comment
  belongs_to :user

  validates_uniqueness_of :user, scope: :comment

  private

  def update_comment_abusive
    # checking equality assures that once author reverts abusive state back
    # this method wont change it to abusive again
    if comment.negative_votes.count == 3
      comment.update_attribute(:abusive, true)
    end
  end
end
