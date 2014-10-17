class StaticPagesController < ApplicationController
  before_action :signed_in_user
  respond_to :html, :json
  
  def home
  end

  def dashboard
    @discover = Question.find_by_sql("SELECT * FROM questions AS q INNER JOIN taggings AS t ON q.id = t.question_id INNER JOIN tags AS ta ON ta.id = t.tag_id WHERE ta.name IN ('#{current_user.first_name.downcase}', '#{current_user.last_name.downcase}', '#{current_user.full_name.downcase}', '#{current_user.user_name.downcase}');")
  end

  def user_questions
    if signed_in?
      # flash[:success] = "Here are the post made by you." 
    end
  end

  def user_statuses
    if signed_in?
      # flash[:success] = "Here are the post made by you." 
    end
  end
  
end
