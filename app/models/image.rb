class Image < ApplicationRecord
  belongs_to :uploader, class_name: "User"
  belongs_to :imageable, polymorphic: true
end
