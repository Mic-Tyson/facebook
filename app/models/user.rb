class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :following_relationships, class_name: "Follow", foreign_key: "follower_id"
  has_many :followed_relationships, class_name: "Follow", foreign_key: "followed_id"

  has_many :following, through: :following_relationships, source: :followed
  has_many :followers, through: :followed_relationships, source: :follower

  has_many :requesting_relationships, class_name: "Request", foreign_key: "requester_id"
  has_many :requested_relationships, class_name: "Request", foreign_key: "requested_id"

  has_many :requesting, through: :requesting_relationships, source: :requested
  has_many :requesters, through: :requester_relationships, source: :requester

  has_many :posts, foreign_key: "author_id", inverse_of: :author

  has_many :likes, dependent: :destroy

  has_many :comments

  has_many :images, foreign_key: :uploader_id

  def following_posts
    Post.where(author_id: following.pluck(:id))
        .order(created_at: :desc)
        .distinct
  end

  def follow(user)
    return if user.nil? || following?(user) || user.id == self.id

    following_relationships.create(followed_id: user.id)
  end

  def following?(user)
    return false if user.nil?

    following_relationships.exists?(followed_id: user.id)
  end

  def unfollow(user)
    return if user.nil? || !following?(user)

    follow_record = following_relationships.find_by(followed_id: user.id)
    follow_record&.destroy
  end

  def likes?(likable)
    return false if likable.nil? || !likeable.likable?

    likes.exists?(likable_id: likable.id, user_id: self.id)
  end

  def like(likable) 
    return if likable.nil? || !likable.likable?

    likes.create(likable: likable)
  end

  def unlike(likable)
    return if likable.nil? || !likable.likable? || !likes.exists?(likable_id: likable.id)

    likes.find_by(likable_id: likable.id)&.destroy
  end
end
