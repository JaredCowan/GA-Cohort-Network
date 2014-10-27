class AnswersController < ApplicationController

  def create 

    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params)

    respond_to do |format|
      if @answer.save
        current_user.create_activity(@answer, 'answered')
        format.html { redirect_to question_path(@question, location: @question)}
        format.json { render json: @question, question: :created }
      else
        format.html { redirect_to question_path(@question)}
      end
    end
  end

  def destroy
    @answer = current_user.answers.find(params[:id])

    respond_to do |format|
      if @answer.destroy
        format.html { redirect_to :back }
        format.json { head :no_content }
        flash[:success] = "Answer was successfully deleted."
      else
        format_generic_error("index")
        flash[:alert] = "There was a problem with deleting your answer."
      end
    end
  end

  private 
    def answer_params
      params.require(:answer).permit(:body, :user_id)
    end
end