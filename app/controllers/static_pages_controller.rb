class StaticPagesController < ApplicationController
  
  def home
    User.all
  end

  def dashboard
    if signed_in? && current_user.created_at > 3.days.ago
      flash[:success] = "Click on a Day to add new event." 
    end
  end
  
end
