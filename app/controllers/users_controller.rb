class UsersController < ApplicationController
  before_action :signed_in_user,
                only: [:index, :edit, :update, :destroy]          

  def index
    @users = User.all

    respond_to do |format|
      format.html
      format.json { render json: @users.to_json(
         include: [:friends]) }
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
      render new_session_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @current_user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to dashboard_url
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
    params.require(:user).permit(:first_name, :last_name, :user_name, :email, :password, :password_confirmation, :friend, :user_id, :friend_id, :state)
  end

  #  def user_friendship
  #   params.require(:user_friendship).permit(:user_id, :friend_id, :user, :friend, :state, :user_friendship)
  # end  
end # End controller