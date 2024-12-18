require 'rails_helper'

RSpec.describe Image, type: :model do
  it { should belong_to(:uploader).class_name("User") }
  it { should belong_to(:imageable) }
end
