class Vote
  include Mongoid::Document
  include Mongoid::Timestamps

  field :value, type: Integer

  belongs_to :comment
  belongs_to :user
end
