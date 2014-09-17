class StatusesController < ApplicationController
  before_action :signed_in_user
  # , only: [:new, :show, :create, :edit, :update, :destroy]
  respond_to :json

  def index
    @statuses = Status.all.reverse_order

    # respond_to do |format|
    #   format.html
    #   format.json { render json: @statuses.to_json(only:
    #     [:id, :content, :created_at, :updated_at,
    #      :user_id, :document_id],
    #      include: [:user, :document]) }
    # end
  end

  def show
    @status = Status.find(params[:id])
    # @status.increment!(:likes) # Temp. not used. Do not uncomment.

    # respond_to do |format|
    #   format.html
    #   format.json { render json: @status }
    # end
  end

  def new
    # @status = Status.new
    @status = current_user.statuses.new
    @attachment.build_document

    respond_to do |format|
      format.html
      format.json { render json: @status }
    end
  end

  def edit
    # @status = Status.find(params[:id])
    @status = current_user.statuses.find(params[:id])
  end

  def create
    @status = current_user.statuses.new(status_params)

    respond_to do |format|
      if @status.save
        format.html { redirect_to :forum, notice: 'Status was successfully created.' }
        format.json { render json: @status, status: :created, location: @status }
      else
        format.html { redirect_to :forum, notice: "That's a no-no. Status is blank." }
      end
    end
  end

  def update

    if current_user.superadmin == true
      @status = Status.find(params[:id])
      @document = @status.document
    else
      @status = current_user.statuses.find(params[:id])
      @document = @status.document
    end
      
    if params[:status] && params[:status].has_key?(:user_id)
      params[:status].delete(:user_id) 
    end

    respond_to do |format|
      if @status.update_attributes(status_params)
        format.html { redirect_to :forum, notice: 'Status was successfully updated.' }
        format.json { head :no_content }
      else
        redirect_to :forum
        # format_generic_error("edit")
      end
    end
  end

  def destroy
    @status = current_user.statuses.find(params[:id])

    respond_to do |format|
      if @status.destroy
        format.html { redirect_to forum_url, notice: 'Status was successfully deleted.' }
        format.json { head :no_content }
      else
        format_generic_error("index")
      end
    end
  end

  private

  def status_params
    params.require(:status).permit(:content, :id, :document_attributes, :attachment)
    params.require(:status).permit!
  end
  def format_generic_error(type)
    redirect_to :feed
    # format.html { redirect_to :statuses_path }
    format.json { render json: @status.errors, status: :unprocessable_entity }
  end
end
