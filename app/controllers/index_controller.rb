class IndexController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    render layout: 'application'
  end
end
