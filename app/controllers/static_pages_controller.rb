class StaticPagesController < ApplicationController
  before_action :signed_in_user
  respond_to :html, :json
  
  def home
  end

  def dashboard
    @discover  = Question.find_by_sql("SELECT * FROM questions AS q INNER JOIN taggings AS t ON q.id = t.question_id INNER JOIN tags AS ta ON ta.id = t.tag_id WHERE ta.name IN ('#{current_user.first_name.downcase}', '#{current_user.last_name.downcase}', '#{current_user.full_name.downcase}', '#{current_user.user_name.downcase}');")
    @lessons   = Lesson.where('instructor LIKE ? OR assistant LIKE ?', "#{current_user.id}", "#{current_user.id}")
    @contacts  = User.all.order("first_name ASC")
    @dashboard = Activity.find_by_sql("SELECT * FROM activities AS a INNER JOIN statuses AS s ON a.targetable_id = s.id INNER JOIN users AS u ON a.user_id = s.user_id WHERE a.user_id IN ('#{current_user.id}');")
  end

  def user_questions
    if signed_in?
    end
  end

  def user_statuses
    if signed_in?
    end
  end
  
end
