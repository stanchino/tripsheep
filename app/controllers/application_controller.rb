class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :catch_cancel, :update => [:create, :update, :destroy]
  after_filter :set_referrer, :only => [:index, :show]
  
  private
    def set_referrer
      session[:referrer] = url_for(params)
    end

    def catch_cancel
      redirect_to(session[:referrer] || root_path) if params[:commit] == "Cancel"
    end
end
