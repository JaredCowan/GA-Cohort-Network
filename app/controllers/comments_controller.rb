class CommentsController < ApplicationController

  def create 
    @status = Status.find(params[:status_id])
    
    @comment = @status.comments.create(comment_params)
    # @comment.user_id = @current_user.user_id
    redirect_to status_path(@status)
  end

  private 
    def comment_params
      params.require(:comment).permit(:body, :user_id)
    end
end