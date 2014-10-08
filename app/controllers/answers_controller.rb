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

  private 
    def answer_params
      params.require(:answer).permit(:body, :user_id)
    end
end