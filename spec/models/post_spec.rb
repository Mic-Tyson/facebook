require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should have_many(:comments) }
  it { should have_many(:images) }
  it { should have_many(:likes) }
  it { should belong_to(:author) }
end
