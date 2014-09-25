class CommentsController < ApplicationController
  respond_to :html, :json

  def create 
    @status = Status.find(params[:status_id])
    @comment = @status.comments.create(comment_params)
    # , location: @status
    # , status: :created
    respond_to do |format|
      if @comment.save
        format.html { redirect_to status_path(@status)}
        format.json { render json: @status }
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