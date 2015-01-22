class UsersController < ApplicationController
  # before_action :params_class, only: [:show]
  before_action :signed_in_user, only: [:edit, :update, :destroy, :index]
  def index
    @users = User.all.page params[:page]

    respond_to do |format|
      format.html
      format.json { render json: @users.to_json(only: [:id],
         include: [
         :statuses, :questions, :answers, 
         :activities, :posts, :user_friendships]
      )}
    end
  end

  def show
    # Check if the URL param passed was :user_name or :id
    type = User.find_by_user_name(params[:id]) ? true : false

    case type
      when true # Param passed was :user_name
        finding_user_by_name = User.find_by_user_name(params[:id])
        @user = finding_user_by_name ? finding_user_by_name : found_user_by_id
      when false # Param passed was :id - Convert :id to :user_name
        try_user_id = params[:id].to_i # Convert :id to Fixnum
        if User.exists?(id: try_user_id) # Check if the user with this :id exists
          find_user_name   = User.where(id: try_user_id).first # Assign found user
          found_user_by_id = User.find_by_user_name(find_user_name[:user_name])
          params[:id]      = find_user_name[:user_name]
          # Render page with :user_name as URL param
          redirect_to user_path(params[:id])
          @user = finding_user_by_name ? finding_user_by_name : found_user_by_id
        else
          flash[:alert] = "We couldn't find that user."
          render file: "public/404" # Error page if nothing is found
        end
      else
        render nothing: true # Render nothing if error
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.user_id, @user.user_name = @user.id, @user.full_name if @user.user_name.blank?
      sign_in @user
      flash[:success] = "Welcome, " + current_user.full_name.to_s
      redirect_to dashboard_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @current_user.update_attributes(user_params)
      # Only create activity for profile updates
      # every 2 hours to prevent flooding
      if current_user.activities.where(targetable_type: "profile").empty? ||
        (!current_user.activities.where(targetable_type: "profile").empty? && current_user.activities.where(targetable_type: "profile").last.created_at < 2.hours.ago)
        Activity.create!(user_id: current_user.id, action: 'updated', targetable_id: current_user.id, targetable_type: "profile")
      end
      flash[:success] = "#{current_user.full_name}, your profile has been updated."
      redirect_to user_path(current_user)
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:warning] = "User destroyed."
    redirect_to new_session_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :user_name, :email, :password,
                                 :password_confirmation, :user_id, :phone, :cell_phone,
                                 :public_email, :birthday, :github, :linkedin, :facebook,
                                 :website, :city, :state, :job_position, :job_start,
                                 :job_end, :job_description, :group, :admin, :job_name
                                )
  end

   def user_friendship
    params.require(:user_friendship).permit(:user_id, :friend_id, :user, :friend, :state, :user_friendship)
  end  
end # End controller