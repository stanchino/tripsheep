class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :catch_cancel, :update => [:create, :update, :destroy]
  after_filter :set_referrer, :only => [:index, :show]
  
  layout :layout

  private

  def layout
    # only turn it off for login pages:
    is_a?(Devise::SessionsController) ? false : "application"
    # or turn layout off for every devise controller:
    devise_controller? && "application"
  end

  private
    def set_referrer
      session[:referrer] = url_for(params)
    end

    def catch_cancel
      redirect_to(session[:referrer] || root_path) if params[:commit] == "Cancel"
    end
end
