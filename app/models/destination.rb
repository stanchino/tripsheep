class Waypoint < ActiveRecord::Base
  attr_accessible :id, :arrival_date, :departure_date, :location, :location_attributes

  belongs_to :trip
  belongs_to :location

  accepts_nested_attributes_for :location
  
  def location_attributes=(hash)
    addr = Gmaps4rails.geocode(hash[:address])
    self.location = Location.find_or_create_by_address(:address => addr.first[:matched_address])
  end
end
