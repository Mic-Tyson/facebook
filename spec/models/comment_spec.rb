require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should have_many(:replies) }
  it { should have_many(:images) }
  it { should have_many(:likes) }
  it { should belong_to(:parent).class_name('Comment').optional  }
end
