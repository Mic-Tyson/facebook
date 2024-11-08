class Post < ApplicationRecord
  belongs_to :author, class_name: "User", inverse_of: :posts

  has_many :likes, as: :likable, dependent: :destroy

  has_many :comments, dependent: :destroy

  has_many :images, as: :imageable # unused for now

  has_one_attached :file

  validates :body, presence: true, length: { in: 10..5000 }
  validates :title, presence: true, length: { in: 10..200 }
end
