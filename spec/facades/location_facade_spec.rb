require 'rails_helper'

RSpec.describe LocationFacade do
  describe ".find_road_trip returns a hash with keys" do
    before do
      roadt_params = {origin: "denver,co", destination: "broomfield,co"}
      @service = LocationFacade.road_trip_time(roadt_params)
    end
    it "time and duration associated to strings", :vcr do
      expect(@service[:time]).to be_a(String)
      expect(@service[:duration]).to be_a(ActiveSupport::Duration)
    end
  end
end