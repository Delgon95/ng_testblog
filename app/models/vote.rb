class Vote
  include Mongoid::Document
  include Mongoid::Timestamps

  field :value, type: Integer

  belongs_to :comment
  belongs_to :user

  validates_uniqueness_of :user, scope: :comment
end
