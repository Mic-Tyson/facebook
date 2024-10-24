class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :follower_relationships, class_name: "Follow", foreign_key: "follower_id"
  has_many :following_relationships, class_name: "Follow", foreign_key: "followed_id"

  has_many :following, through: :following_relationships, source: :followed
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :requester_relationships, class_name: "Request", foreign_key: "requester_id"
  has_many :requesting_relationships, class_name: "Request", foreign_key: "requested_id"

  has_many :requesting, through: :requesting_relationships, source: :requested
  has_many :requesters, through: :requester_relationships, source: :requester

  has_many :posts, foreign_key: "author_id", inverse_of: :author

  has_many :likes, dependent: :destroy

  has_many :comments

  has_many :images, foreign_key: :uploader_id
end
