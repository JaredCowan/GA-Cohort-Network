class StaticPagesController < ApplicationController
  before_action :signed_in_user
  respond_to :html, :json
  
  def home
  end

  def dashboard
    if signed_in? && current_user.created_at > 3.days.ago
      flash[:success] = "Click on a Day to add new event." 
    end
  end
  
end
