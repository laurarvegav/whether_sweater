require 'rails_helper'

RSpec.describe Munchie do
  describe 'Initialize' do
    it "exists and populates attribures corerctly" do
      munchie = Munchie.new( 
        { name: "Tavernetta", review_count: 693, raiting: 4.5, location: 
          {display_address: [
            "1889 16th St",
            "Denver, CO 80202"
            ]
          }
        }
      )
      
      expect(munchie).to be_a(Munchie)
      
      expect(munchie.name).to eq("Tavernetta")
      
      expect(munchie.address).to eq("1889 16th St, Denver, CO 80202")
      expect(munchie.raiting).to eq(4.5)
      expect(munchie.reviews).to eq(693)
    end
  end
end
