class Location < ActiveRecord::Base
  acts_as_gmappable :process_geocoding => :geocode?,
    :address => "full_address", :normalized_address => "address",
    :msg => "Sorry, the address was not found"

  attr_accessible :address, :address1, :city, :country, :state, :zip, :order, :longitude, :latitude
  validates_uniqueness_of :address
  validates_uniqueness_of :latitude, :longitude
  validates_presence_of :address, on: :create

  has_many :destinations
  has_many :trips, through: :destinations
  
  
  def full_address
    [self.address, self.city, self.country].find_all{|item| !item.blank?}.join(", ")
  end

  def geocode?
    (!address.blank? && (latitude.blank? || longitude.blank?)) || address_changed?
  end

end
