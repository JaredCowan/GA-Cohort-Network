class CommentsController < ApplicationController

  def create 

    @status = Status.find(params[:status_id])
    @comment = @status.comments.create(comment_params)

    respond_to do |format|
      if @comment.save
        current_user.create_activity(@comment, 'created')
        format.html { redirect_to status_path(@status, location: @comment)}
        format.json { render json: @status, comment: :created }
      else
        format.html { redirect_to status_path(@status)}
      end
    end
  end

  private 
    def comment_params
      params.require(:comment).permit(:body, :user_id, :id, :question_id, :status_id)
    end
end