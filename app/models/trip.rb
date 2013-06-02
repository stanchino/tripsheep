class Trip < ActiveRecord::Base
  attr_accessible :name, :start, :finish, :waypoints, :waypoints_attributes
  has_many :waypoints
  accepts_nested_attributes_for :waypoints
  
  has_many :locations, through: :waypoints
  
  def name
    "From #{self.locations.first.address} to #{self.locations.last.address}" unless
      self.locations.first.nil? or self.locations.last.nil?
  end
 
=begin
  def waypoints_attributes=(hash)
    hash.each do |sequence,attributes|
      location = Location.first_or_initialize(:address => attributes[:location_attributes][])
      unless location.new_record?
        attributes[:location_id] = location.id
        attributes.delete(:location_attributes) 
      end
      waypoints << Waypoint.new(attributes)
    end
  end
=end
end
