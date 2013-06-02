class IndexController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @trip = current_user.trips.last || current_user.trips.create!
    @json = Location.all.to_gmaps4rails
    render :layout => 'application'
  end
end
