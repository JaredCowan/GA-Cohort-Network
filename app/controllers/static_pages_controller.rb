class StaticPagesController < ApplicationController
  
  def home
    User.all
  end

  def dashboard
  end
  
end
