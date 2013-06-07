class Trip < ActiveRecord::Base
  PENDING = 'pending'
  SAVED = 'saved'
  
  attr_accessible :name, :start, :finish, :destinations, :destinations_attributes, :status

  has_many :destinations
  accepts_nested_attributes_for :destinations
  
  has_many :locations, through: :destinations

  before_create :add_destinations
  
  def name
    "From #{self.locations.first.address} to #{self.locations.last.address}" unless
      self.locations.first.nil? or self.locations.last.nil?
  end

  def intervals
    intervals = []
    self.destinations.each_with_index do |destination, i|
      intervals << {:first => destination, :last => self.destinations[i+1]} unless destination.last?
    end
    return intervals
  end
  
  def waypoints
    self.destinations[1..-1]
  end
  
  def directions
    { 
      :data => { 
        :from => self.destinations.first.address,
        :to => self.destinations.last.address
      }, 
      :options => { 
        :waypoints => self.waypoints.map{ |w| w.address },
        :display_panel => true, 
        :panel_id => "instructions"
      } 
    }
  end
  
  private
    def add_destinations
      self.destinations << [Destination.new(:position => 1), Destination.new(:position => 2)]
    end
end
