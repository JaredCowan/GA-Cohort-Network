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

  rescue_from ActionController::RoutingError, :with => :render_not_found

def routing_error
  raise ActionController::RoutingError.new(params[:path])
end

def render_not_found
  render "public/404"
end

  include SessionsHelper

end # End controller
