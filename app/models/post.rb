class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable

  field :body, type: String
  field :title, type: String
  field :archived, type: Boolean, default: false

  validates_presence_of :body, :title

  belongs_to :user
  has_many :comments

  default_scope ->{ ne(archived: true) }

  def archive!
    update_attribute :archived, true
  end

  def hotness
   age_score + (commented_by(3) ? 1 : 0)
  end

  private

  def age_score
    return 0 if age > 7.days
    return 1 if age > 3.days
    return 2 if age > 1.day
    return 3
  end

  def age
    Time.now - created_at
  end

  def commented_by amount
    comments.count >= amount
  end
end
