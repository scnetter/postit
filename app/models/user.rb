class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  before_save :generate_slug

  has_secure_password validations: false
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: { minimum: 5 }

  def to_param
    self.slug
  end

  def generate_slug
    self.slug = self.username.gsub(' ', '-').downcase
  end

  def admin?
    self.role == 'admin'
  end

  def moderator?
    self.role =='moderator'
  end
end
