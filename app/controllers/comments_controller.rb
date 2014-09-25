class CommentsController < ApplicationController

  def create 
    @status = Status.find(params[:status_id])
    @comment = @status.comments.create(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to status_path(@status)}
        format.json { render json: @status, status: :created, location: @status }
      else
        format.html { redirect_to status_path(@status)}
      end
    end
  end

  private 
    def comment_params
      params.require(:comment).permit(:body, :user_id)
    end
end