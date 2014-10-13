class UsersController < ApplicationController
  before_action :signed_in_user,
                only: [:index, :edit, :update, :destroy]           
  
  def index
    @users = User.all.page params[:page]

    respond_to do |format|
      format.html
      format.json { render json: @users.to_json(only: [:id],
         include: [:statuses]) }
    end
  end

  def show
    @user = User.find(params[:id])
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
      render dashboard_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @current_user.update_attributes(user_params)
      # current_user.create_activity @user, 'profile'
      flash[:success] = "Profile updated"
      redirect_to user_path(current_user)
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to new_session_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :user_name, :email, :password, :password_confirmation,
      :friend, :user_id, :friend_id, :state, :phone, :cell_phone, :public_email, :birthday, :github, :linkedin,
      :facebook, :website, :city, :state, :job_position, :job_start, :job_end, :job_description, :group, :admin, :job_name)
  end

   def user_friendship
    params.require(:user_friendship).permit(:user_id, :friend_id, :user, :friend, :state, :user_friendship)
  end  
end # End controller