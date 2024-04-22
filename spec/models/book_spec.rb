require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:isbn) }
    it { should validate_presence_of(:publisher) }
  end
end
