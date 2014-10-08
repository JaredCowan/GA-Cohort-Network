class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_action :update_time

  def update_time
    if current_user
      current_user.update!(updated_at: Time.now)
    end
  end

  def can_administer?
    true
    # current_user
  end

  include SessionsHelper

end # End controller
