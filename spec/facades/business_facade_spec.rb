require 'rails_helper'

RSpec.describe BusinessFacade do
  describe '.find_munchie' do
    before do
      munchie_params = {destination: "pueblo,co", food:"italian"}
      @service = BusinessFacade.find_munchie(munchie_params)
    end

    it "retuns a munchie objec", :vcr do
      expect(@service).to be_a(Munchie)
    end
  end
end