class Post < ApplicationRecord
  belongs_to :author, class_name: "User", inverse_of: :posts

  has_many :likes, as: :likable, dependant: :destroy
end
