class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :follower_relationships, class_name: "Follow", foreign_key: "follower_id"
  has_many :following_relationships, class_name: "Follow", foreign_key: "followed_id"

  has_many :following, through: :following_relationships, source: :followed
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :posts, foreign_key: "author_id", inverse_of: :author

  has_many :likes, dependent: :destroy

  has_many :comments
end
