class IndexController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @json = Location.all.to_gmaps4rails
    render :layout => 'application'
  end
end
