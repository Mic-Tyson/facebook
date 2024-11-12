class Post < ApplicationRecord
  belongs_to :author, class_name: "User", inverse_of: :posts

  has_many :likes, as: :likable, dependent: :destroy

  has_many :comments, dependent: :destroy

  has_many :images, as: :imageable # unused for now

  has_one_attached :file

  validates :body, presence: true, length: { in: 10..5000 }
  validates :title, presence: true, length: { in: 10..200 }

  validate :max_file_size

  private

  def max_file_size
    return unless file.attached?

    if file.blob.byte_size > 5.megabytes
      file.purge
      errors.add(:file, "should be less than 5MB")
    end
  end
end
