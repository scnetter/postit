class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  before_save :generate_slug

  validates :title, presence: true, length: {minimum: 5, maximum: 25}
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true, length: {maximum: 300}
  default_scope { order(updated_at: :desc) }

  def total_votes
    self.up_votes - self.down_votes
  end

  def up_votes
    self.votes.where(vote: true).size
  end

  def down_votes
    self.votes.where(vote: false).size
  end

  def generate_slug
    self.slug = self.title.gsub(' ', '-').downcase
    # TODO: Play with REGEX
    # Append numbers if non-unique
    # rubular.com to test regex
  end

  def to_param
    self.slug
  end
end
