class ProfilesController < ApplicationController
before_action :signed_in_user
  def show
    @user = User.find(params[:id])
    if @user
        @statuses = @user.statuses.load
        render action: :show
    else
        render file: 'public/404', status: 404, formats: [:html]
    end
  end

end
