class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likable, polymorphic: true


  LIKABLE_TYPES = %w[Post Comment]
end
