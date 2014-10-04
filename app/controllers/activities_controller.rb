class ActivitiesController < ApplicationController
  # respond_to :html, :json
  def index
    @activities = Activity.all.page params[:page]
    # respond_with @activities
    session[:return_to] ||= request.referer
  end

  def upvote
    @status = Status.find(params[:id])
    @status.liked_by current_user
    session[:return_to] ||= request.referer
    redirect_to session.delete(:return_to)
  end

  def downvote
    @status = Status.find(params[:id])
    @status.downvote_from current_user
    session[:return_to] ||= request.referer
    redirect_to session.delete(:return_to)
  end

end