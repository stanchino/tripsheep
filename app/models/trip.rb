class Trip < ActiveRecord::Base
  PENDING = 'pending'
  SAVED = 'saved'
  
  attr_accessible :name, :start_date, :end_date, :destinations, :destinations_attributes, :status
  validates_presence_of :name, :start_date

  has_many :destinations
  accepts_nested_attributes_for :destinations
  
  has_many :locations, through: :destinations

  #before_create :add_destinations
  
  def intervals
    intervals = []
    self.destinations.each_with_index do |w, i|
      intervals << [w, self.destinations[i+1]] unless self.destinations[i+1].nil?
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
