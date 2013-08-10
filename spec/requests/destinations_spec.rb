require 'spec_helper'

describe "Destinations" do

  let(:trip) { FactoryGirl.create(:trip) }

  describe "GET /trip/{id}/destinations" do
    it "works! (now write some real specs)" do
      pending "Add authentication"
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get trip_destinations_path(trip.id)
      response.status.should be(200)
    end
  end
end
