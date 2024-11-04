module Likable
  extend ActiveSupport::Concern

  def likable?
    Like::LIKABLE_TYPES.include?(self.class.name)
  end
end