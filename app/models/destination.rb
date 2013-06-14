class Destination < ActiveRecord::Base
  attr_accessible :id, :arrival_date, :departure_date, :location,
    :location_attributes, :position, :days, :hours
  
  belongs_to :trip
  belongs_to :location

  accepts_nested_attributes_for :location
  
  delegate :address, to: :location, prefix: false, allow_nil: true
  
  acts_as_list scope: :trip
  default_scope order(:position)
  
  validates_presence_of :days
  validates :days, numericality: { greater_than_or_equal_to: 0 }
  validates_presence_of :hours, unless: Proc.new { |r| r.days > 0 }
  validates :hours, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 24 }
  
  def is_removable?
    !self.first? && !self.last?
  end

  def location_attributes=(hash)
    if hash[:id].nil?
      addr = Gmaps4rails.geocode(hash[:address]).pop()
      self.location = Location.find_by_address(addr[:matched_address])
      if self.location.nil?
        self.create_location!(:address => addr[:matched_address])
      end
    end
  end
end
