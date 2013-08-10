require "spec_helper"

describe DestinationsController do

  let(:trip) { FactoryGirl.create(:trip) }
  
  describe "routing" do
    it "routes to #index" do
      get("/trips/#{trip.id}/destinations").should route_to("destinations#index", :trip_id => "#{trip.id}")
    end

    it "routes to #new" do
      get("/trips/#{trip.id}/destinations/new").should route_to("destinations#new", :trip_id => "#{trip.id}")
    end

    it "routes to #show" do
      get("/trips/#{trip.id}/destinations/1").should route_to("destinations#show", :trip_id => "#{trip.id}", :id => "1")
    end

    it "routes to #edit" do
      get("/trips/#{trip.id}/destinations/1/edit").should route_to("destinations#edit", :trip_id => "#{trip.id}",  :id => "1")
    end

    it "routes to #create" do
      post("/trips/#{trip.id}/destinations").should route_to("destinations#create", :trip_id => "#{trip.id}")
    end

    it "routes to #update" do
      put("/trips/#{trip.id}/destinations/1").should route_to("destinations#update", :trip_id => "#{trip.id}", :id => "1")
    end

    it "routes to #destroy" do
      delete("/trips/#{trip.id}/destinations/1").should route_to("destinations#destroy", :trip_id => "#{trip.id}", :id => "1")
    end

  end
end
