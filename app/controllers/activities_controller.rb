class ActivitiesController < ApplicationController
  # respond_to :html, :json
  def index
    @activities = Activity.all.reverse
  end
end