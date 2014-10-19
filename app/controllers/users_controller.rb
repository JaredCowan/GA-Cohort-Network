class UsersController < ApplicationController
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
    if params[:id]
      @user = User.find(params[:id])
    elsif params[:user_name]
      @user = User.find_by_user_name params[:user_name]
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
      flash[:success] = "Profile updated"
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
    params.require(:user).permit(:first_name, :last_name, :user_name, :email, :password, :password_confirmation,
      :user_id, :phone, :cell_phone, :public_email, :birthday, :github, :linkedin,
      :facebook, :website, :city, :state, :job_position, :job_start, :job_end, :job_description, :group, :admin, :job_name)
  end

   def user_friendship
    params.require(:user_friendship).permit(:user_id, :friend_id, :user, :friend, :state, :user_friendship)
  end  
end # End controller