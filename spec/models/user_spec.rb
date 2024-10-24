require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:posts) }
  it { should have_many(:comments) }
  it { should have_many(:images) }
  it { should have_many(:likes) }
  it { should have_many(:followers).through(:follower_relationships) }
  it { should have_many(:following).through(:following_relationships) }
  it { should have_many(:requesters).through(:requester_relationships) }
  it { should have_many(:requesting).through(:requesting_relationships) }
end
