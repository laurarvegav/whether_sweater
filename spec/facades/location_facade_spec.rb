equire 'rails_helper'

RSpec.describe ServicesFacade do
  describe ".find_road_trip returns a hash with keys" do
    before do
      roadt_params = {origin: "denver,co", destination: "broomfield,co"}
      @service = LocationFacade.find_road_trip(roadt_params)
    end
    it "road_trip associated to a RoadTrip object" do
      expect(@service[:travel_time]).to be_a(String)
      expect(@service[:road_trip]).to be_a(RoadTrip)
    end
  end
end