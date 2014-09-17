class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :update_time

  def update_time
    if current_user
      current_user.update!(updated_at: Time.new)
    end
  end 

  include SessionsHelper

end # End controller
