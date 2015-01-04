class QuestionsController < ApplicationController
  before_action  :signed_in_user
  before_action  :set_question, only: [:show, :edit, :update, :destroy]
  # respond_to :html, :json

  def index
    if params[:tag]
      begin
        @questions = Question.tagged_with(params[:tag])
      rescue ActiveRecord::RecordNotFound  
        flash[:alert] = "Sorry, we couldn't find anything with that tag."
        redirect_to questions_path 
      end
    else
      @questions = Question.all.reverse_order.page params[:page]
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
    # @document.build_document

    respond_to do |format|
      format.html
      format.json { render json: @question }
    end
  end

  def edit
    @question = current_user.questions.find(params[:id])
  end

  def create
    @question = current_user.questions.new(question_params)

    respond_to do |format|
      if @question.save
        current_user.create_activity(@question, 'created')
        format.html { redirect_to questions_path }
        format.json { render json: questions_path, question: :created, location: @question }
        flash[:success] = "Question was successfully created."
      else
        format.html { redirect_to :back, notice: "#{@question.errors.count} error(s) prohibited this question from being saved: #{@question.errors.full_messages.join(', ')}" }
        format.json { render json: @question.errors, question: :unprocessable_entity }
      end
    end
  end


  def update
    # if current_user
    #   @status   = Status.find(params[:id])
    #   @document = @status.document
    # else
      @question   = current_user.questions.find(params[:id])
      # @question.document.user_id = current_user.id
      # @document = @question.document
    # end
      
    respond_to do |format|
      if @question.update_attributes(question_params)
        current_user.create_activity(@question, 'updated')
        format.html { redirect_to question_path(@question) }
        format.json { head :no_content }
        flash[:success] = "Question was successfully updated."
      else
        redirect_to question_path(@question)
        format_generic_error("edit")
      end
    end
  end

  def destroy
    @question = current_user.questions.find(params[:id])

    respond_to do |format|
      if @question.destroy
        format.html { redirect_to questions_path, notice: 'Question was successfully deleted.' }
        format.json { head :no_content }
      else
        format_generic_error("index")
      end
    end
  end

  def upvote
    @question = Question.find(params[:id])
    @question.liked_by current_user
    # current_user.create_activity(@question, 'liked')

    respond_to do |format|
      format.html {redirect_to :back }
      format.json { render json: @question, include: [:get_upvotes, :answers] }
    end
  end

  def downvote
    @question = Question.find(params[:id])
    # @activity = Activity.find_by(targetable_id: @question)
    # @activity.destroy
    @question.downvote_from current_user

    respond_to do |format|
      format.html {redirect_to :back }
      format.json { render json: @question, include: [:get_upvotes, :answers] }
    end
  end

  private

  def question_params
    params.require(:question).permit(:subject, :body, :id, :document_attributes, :attachment, :content, :name, :tag_list, :user_id)
    params.require(:question).permit!
  end

  def format_generic_error(type)
    redirect_to questions_path
    format.html { redirect_to :questions_path }
    format.json { render json: @question.errors, question: :unprocessable_entity }
  end

  def set_question
    @question = Question.find(params[:id])
  end

end
