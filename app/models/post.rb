class Post < ApplicationRecord
  belongs_to :author, class_name: "User", inverse_of: :posts

  has_many :likes, as: :likable, dependant: :destroy

  has_many :comments, dependent: :destroy
end
