class Trip < ActiveRecord::Base
  attr_accessible :name, :start, :finish, :destinations, :destinations_attributes
  has_many :destinations
  accepts_nested_attributes_for :destinations
  
  has_many :locations, through: :destinations
  
  def name
    "From #{self.locations.first.address} to #{self.locations.last.address}" unless
      self.locations.first.nil? or self.locations.last.nil?
  end
  
  def intervals
    intervals = []
    self.destinations.each_with_index do |w, i|
      intervals << [w, self.destinations[i+1]] unless self.destinations[i+1].nil?
    end
    return intervals
  end
  
  def directions
    { 
      :data => { 
        :from => self.destinations.first.address,
        :to => self.destinations.last.address
      }, 
      :options => { 
        :destinations => self.destinations[1..-1].map{|w| w.address},
        :display_panel => true, 
        :panel_id => "instructions"
      } 
    }
  end
end
