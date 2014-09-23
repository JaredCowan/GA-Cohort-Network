class JobsController < ApplicationController
  before_action :signed_in_user
  respond_to :html, :json

  def index
    @jobs = Job.all
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
    @jobs = current_user.jobs.new

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
        format.html { redirect_to :jobs, notice: 'Job was successfully created.' }
        format.json { render json: @jobs }
      else
        format.html { redirect_to :jobs, notice: "Error creating Job." }
      end
    end
  end

  def update

    if current_user
      @job = Job.find(params[:id])
    else
      @job = current_user.jobs.find(params[:id])
    end
      
    # if params[:job] && params[:job].has_key?(:user_id)
    #   params[:job].delete(:user_id) 
    # end

    respond_to do |format|
      if @job.update_attributes(job_params)
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

  private

  def job_params
    params.require(:job).permit(:user_id, :company, :contact_person, :contact_email, :contact_number, :website, :start_date, :url, :position, :salery, :job_type, :desription, :responsibilities, :qualifications, :address, :city, :state, :zip)
    params.require(:job).permit!
  end
  def format_generic_error(type)
    redirect_to :jobs
    format.json { render json: @job.errors, job: :unprocessable_entity }
  end

end
