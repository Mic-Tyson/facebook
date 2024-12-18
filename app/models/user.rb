class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :following_relationships, foreign_key: "follower_id", class_name: "Follow"
  has_many :following, through: :following_relationships, source: :followed

  has_many :followed_relationships, class_name: "Follow", foreign_key: "followed_id"
  has_many :followers, through: :followed_relationships, source: :follower

  has_many :requesting_relationships, class_name: "Request", foreign_key: "requester_id"
  has_many :requesting, through: :requesting_relationships, source: :requested

  has_many :requested_relationships, class_name: "Request", foreign_key: "requested_id"
  has_many :requesters, through: :requested_relationships, source: :requester

  has_many :posts, foreign_key: "author_id", inverse_of: :author

  has_many :likes, dependent: :destroy

  has_many :comments

  has_many :images, foreign_key: :uploader_id

  has_one_attached :avatar

  validate :avatar_size

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

  def requesting?(user)
    return false if user.nil? || user == self || following?(user)

    requesting_relationships.exists?(requested_id: user.id)
  end

  def request_follow(user)
    return nil if user.nil? || self.requesting?(user)

    requesting_relationships.create(requested_id: user.id)
  end

  def unrequest_follow(user)
    return nil if user.nil? || following?(user) || !requesting?(user)

    requesting_relationships.find_by(requested_id: user.id)&.destroy
  end

  def accept_follow_request(user)
    return nil unless user.requesting?(self)

    user.follow(self)
    requested_relationships.find_by(requester_id: user.id)&.destroy
  end

  def deny_follow_request(user)
    return nil unless user.requesting?(self)

    requested_relationships.find_by(requester_id: user.id)&.destroy
  end

  def likes?(likable)
    return false if likable.nil? || !likable.likable?

    likes.exists?(likable_id: likable.id)
  end

  def like(likable)
    return if likable.nil? || !likable.likable?

    if likes?(likable)
      unlike(likable)
    else
      likes.create(likable: likable)
    end
  end

  def unlike(likable)
    return if likable.nil? || !likable.likable? || !likes.exists?(likable_id: likable.id)

    likes.find_by(likable_id: likable.id)&.destroy
  end

  private

  def avatar_size
    return unless avatar.attached?

    if avatar.blob.byte_size > 3.megabytes
      avatar.purge
      errors.add(:avatar, "should be less than 3MB")
    end
  end
end
