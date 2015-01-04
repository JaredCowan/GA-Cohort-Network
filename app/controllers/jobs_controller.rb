class JobsController < ApplicationController
  before_action :signed_in_user
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json

  def index
    @jobs = Job.all.page params[:page]
    respond_to do |format|
      format.html
      format.json { render json: @jobs}
    end
  end

  def show
    @job = Job.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @jobs }
    end
  end

  def new
    @job = current_user.jobs.build

    respond_to do |format|
      format.html
      format.json { render json: @jobs }
    end
  end

  def edit
    @job = current_user.job.find(params[:id])
  end

  def create
    @job = current_user.jobs.new(job_params)

    respond_to do |format|
      if @job.save
        current_user.create_activity(@job, 'created')
        format.html { redirect_to :jobs, notice: 'Job was successfully created.' }
        format.json { render json: @jobs }
      else
        format.html { redirect_to :jobs, notice: "Error creating Job." }
      end
    end
  end

  def update

    if current_user
      @jobs = Job.find(params[:id])
    else
      @jobs = current_user.jobs.find(params[:id])
    end
      
    # if params[:job] && params[:job].has_key?(:user_id)
    #   params[:job].delete(:user_id) 
    # end

    respond_to do |format|
      if @job.update_attributes(job_params)
        current_user.create_activity(@job, 'updated')
        format.html { redirect_to jobs_path(@job), notice: 'Job was successfully updated.' }
        format.json { head :no_content }
      else
        redirect_to :jobs
        format_generic_error("edit")
      end
    end
  end

  def destroy
    @job = current_user.jobs.find(params[:id])

    respond_to do |format|
      if @job.destroy
        format.html { redirect_to jobs_url, notice: 'Job was successfully deleted.' }
        format.json { head :no_content }
      else
        format_generic_error("index")
      end
    end
  end

  def upvote
    @job = Job.find(params[:id])
    @job.liked_by current_user
    current_user.create_activity(@job, 'upvoted')

    respond_to do |format|
      format.html {redirect_to :back }
      format.json { render json: @job }
    end
  end

  def downvote
    @job = Job.find(params[:id])
    @activity = Activity.find_by(targetable_id: @job)
    @activity.destroy
    @job.downvote_from current_user

    respond_to do |format|
      format.html {redirect_to :back }
      format.json { render json: @job, include: [:get_upvotes] }
    end
  end

  private

  def job_params
    params.require(:job).permit(:user_id, :company, :contact_person, :contact_email, :contact_number, :website, :start_date, :url, :position, :salery, :job_type, :desription, :responsibilities, :qualifications, :address, :city, :state, :zip)
    params.require(:job).permit!
  end

  def format_generic_error(type)
    redirect_to :jobs
    format.json { render json: @job.errors, job: :unprocessable_entity }
  end

  def set_job
    @job = Job.find(params[:id])
  end

end
