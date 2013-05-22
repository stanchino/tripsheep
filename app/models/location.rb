class Location < ActiveRecord::Base
  acts_as_gmappable :process_geocoding => :geocode?,
    :address => "full_address", :normalized_address => "address",
    :msg => "Sorry, the address was not found"

  attr_accessible :address, :address1, :city, :country, :state, :zip, :order, :longitude, :latitude
  
  belongs_to :user
  
  def full_address
    "#{self.address}, #{self.city}, #{self.country}" 
  end

  def geocode?
    (!address.blank? && (latitude.blank? || longitude.blank?)) || address_changed?
  end
end
