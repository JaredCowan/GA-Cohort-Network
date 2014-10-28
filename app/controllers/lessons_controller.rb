class LessonsController < ApplicationController
  before_action :signed_in_user
  respond_to :html, :json

  def index
    @lessons = Lesson.all.page params[:page]
    # respond_with @lessons.where(user_id: 4)
    # respond_to do |format|
    #   format.html
    #   format.json { render json: @lessons}
    # end
  end

  def show
    @lesson = Lesson.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @lessons }
    end
  end

  def new
    @lesson = current_user.lessons.new
    # @attachment.build_document

    respond_to do |format|
      format.html
      format.json { render json: @lesson }
    end
  end

  def edit
    @lesson = current_user.lessons.find(params[:id])
  end

  def create
    @lesson = current_user.lessons.new(lesson_params)

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to :back }
        format.json { render json: @lesson }
        flash[:success] = "Lesson was successfully created."
      else
        format.html { redirect_to :lessons }
        flash[:error] = "Error: Lesson is blank."
      end
    end
  end

  def update

    if current_user
      @lesson = Lesson.find(params[:id])
    else
      @lesson = current_user.lessons.find(params[:id])
    end
      
    if params[:lesson] && params[:lesson].has_key?(:user_id)
      params[:lesson].delete(:user_id) 
    end

    respond_to do |format|
      if @lesson.update_attributes(lesson_params)
        format.html { redirect_to lessons_path(@lesson) }
        format.json { head :no_content }
        flash[:success] = "Lesson was successfully updated."
      else
        redirect_to :lessons
        format_generic_error("edit")
        flash[:error] = "Error updating lesson."
      end
    end
  end

  def destroy
    @lesson = current_user.lessons.find(params[:id])

    respond_to do |format|
      if @lesson.destroy
        format.html { redirect_to lessons_url }
        format.json { head :no_content }
        flash[:success] = "Lesson was successfully deleted."
      else
        format_generic_error("index")
      end
    end
  end

  private

  def lesson_params
    params.require(:lesson).permit(:instructor, :classroom, :assistant, :subject, :title, :description, :user_id, :start, :end, :all_day, :document_attributes, :attachment)
    params.require(:lesson).permit!
  end
  def format_generic_error(type)
    redirect_to :lesson
    format.json { render json: @lesson.errors, lesson: :unprocessable_entity }
  end
end # End controller