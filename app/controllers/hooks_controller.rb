class HooksController < ApplicationController
  respond_to :json
  skip_before_filter  :verify_authenticity_token

  def post_callback
    request.body.rewind
    pay = JSON.parse(request.body.read)
    action = "#{pay['action']}"

    action == "created"
    usr = {:username => ENV['GH_VALUE']}
    issuebody = %(<a href="#"><img src="http://www.codereviewhub.com/site/github-approved-avatar.png" align="left" height="34" width="246"><img src='https://avatars.githubusercontent.com/u/7110664?v=3' width=34 height=34></a>) 
    post = HTTParty.patch("https://api.github.com/repos/JaredCowan/Ga-Cohort-Network/issues/1", :headers => { "User-Agent" => usr[:username], "Authorization" => ENV['GH_TOKEN'] }, :body => { :body => issuebody}.to_json) 

    render :nothing => true
  end
end
