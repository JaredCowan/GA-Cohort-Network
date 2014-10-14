class ApplicationController < ActionController::Base

  if Rails.env == "production"
    rescue_from Exception, :with => :render_500
    rescue_from NoMethodError, :with => :render_not_found
  end

  rescue_from ActionController::RoutingError, :with => :render_not_found
  protect_from_forgery with: :exception
  before_action :update_time
  include SessionsHelper

  def update_time
    if current_user
      current_user.update!(updated_at: Time.now)
    end
  end

  def can_administer?
    true
    # current_user
  end

  def render_500(exception)
    @exception = exception
    flash.now[:error] = 'There was a error with your last request'
    render "public/500"
  end

  def routing_error
    raise ActionController::RoutingError.new(params[:path])
  end

  def render_not_found
    render "public/404"
  end

end