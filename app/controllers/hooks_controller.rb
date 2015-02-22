class HooksController < ApplicationController
  respond_to :json
  skip_before_filter  :verify_authenticity_token

  def post_callback
    request.body.rewind
    pay = JSON.parse(request.body.read)
    # puts pay['action']
    puts params

    if pay['action'] == "post_callback"
      post = HTTParty.patch("https://api.github.com/repos/JaredCowan/Ga-Cohort-Network/issues/1", :headers => { "User-Agent" => usr[:username], "Authorization" => ENV['GH_TOKEN'] }, :body => { :body => body}.to_json) 
      body = %(<a href="#"><img src="http://www.codereviewhub.com/site/github-approved-avatar.png" align="left" height="34" width="246"><img src='https://avatars.githubusercontent.com/u/7110664?v=3' width=34 height=34></a>) 
      usr = {:username => ENV['GH_VALUE']}
      # puts post
    end

    render :nothing => true
  end
end
