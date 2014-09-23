class ApplicationController < ActionController::Base
  # rescue ArgumentError
  #  redirect_to conversations_path

  protect_from_forgery with: :exception

  before_action :update_time

  def update_time
    if current_user
      current_user.update!(updated_at: Time.new)
    end
  end 

  include SessionsHelper

end # End controller
