class Post < ApplicationRecord
  # Associations
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  # Attributes
  attribute :title, :string
  attribute :text, :text
  attribute :comments_couter, :integer, default: 0
  attribute :likes_counter, :integer, default: 0

  # Callback
  after_save :update_user_posts_counter

  # Methods
  def five_most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def update_user_posts_counter
    author.update(posts_counter: author.posts.count + 1)
  end
end