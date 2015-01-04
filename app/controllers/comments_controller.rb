class CommentsController < ApplicationController
  respond_to :html, :json

  def index
    @comments = Comment.all
  end

  def update
      @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(comment_params)
        format.html { redirect_to :back, notice: 'Comment was successfully updated.' }
        format.json { render json: @comment }
      else
        redirect_to :back
      end
    end
  end

  def create 

    # @status = Status.find(params[:status_id])
    # @comment = @status.comments.create(comment_params)
    @comment = Comment.create(comment_params)
    respond_to do |format|
      if @comment.save
        current_user.create_activity(@comment, 'created')
        # format.html { redirect_to status_path(@status, location: @comment)}
        format.html { redirect_to :back}
        format.json { render json: @status, comment: :created }
        flash[:success] = "Comment was added."
      else
        format.html { redirect_to :back}
        flash[:alert] = "There was a problem with submitting your comment."
      end
    end
  end

   def destroy
    @comment = current_user.comments.find(params[:id])

    respond_to do |format|
      if @comment.destroy
        format.html { redirect_to :back }
        format.json { head :no_content }
        flash[:success] = "Comment was successfully deleted."
      else
        format_generic_error("index")
        flash[:alert] = "There was a problem with submitting your comment."
      end
    end
  end

  private 
    def comment_params
      params.require(:comment).permit(:body, :user_id, :id, :question_id, :status_id)
    end
end