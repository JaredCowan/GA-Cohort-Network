class ApplicationController < ActionController::Base

  rescue_from ActionController::RoutingError, :with => :render_not_found
  protect_from_forgery with: :exception
  rescue_from Exception, :with => :render_500
  before_action :update_time
  include SessionsHelper

  def render_500(exception)
    @exception = exception
    flash.now[:error] = 'There was a error with your last request'
    redirect_to dashboard_url
  end

  def update_time
    if current_user
      current_user.update!(updated_at: Time.now)
    end
  end

  def can_administer?
    true
    # current_user
  end

  def routing_error
    raise ActionController::RoutingError.new(params[:path])
  end

  def render_not_found
    render "public/404"
  end
end