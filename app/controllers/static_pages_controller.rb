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

  def user_questions
    if signed_in?
      flash[:success] = "Here are the post made by you." 
    end
  end
  
end
