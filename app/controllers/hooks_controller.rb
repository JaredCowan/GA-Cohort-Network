class HooksController < ApplicationController
  respond_to :json
  skip_before_filter  :verify_authenticity_token

  def post_callback
    request.body.rewind
    payload = JSON.parse(request.body.read)
    action = "#{payload['action']}"
    name = ENV['verdebotname']
    token = ENV['verdebottoken']
    # if action == "created"
    #   comment = payload['comment']


    #   usr = {:username => ENV['GH_VALUE']}
    #   issuebody = %(<a href="#"><img src="http://www.codereviewhub.com/site/github-approved-avatar.png" align="left" height="34" width="246"><img src='https://avatars.githubusercontent.com/u/7110664?v=3' width=34 height=34></a>) 
    #   post = HTTParty.post("https://api.github.com/repos/JaredCowan/Ga-Cohort-Network/issues/1/comments", :headers => { "User-Agent" => usr[:username], "Authorization" => ENV['GH_TOKEN'] }, :body => { :body => issuebody}.to_json) 
    # end

    # if action == "opened"
      usr = {:username => "#{name}"}
      issuebody = payload['issue']['body']
      addon = %(<a href="#"><img src="http://www.codereviewhub.com/site/github-approved-avatar.png" align="left" height="34" width="246"><img src='https://avatars.githubusercontent.com/u/7110664?v=3' width=34 height=34></a>) 

      final = "#{issuebody} \r\n #{addon} \r\n @JaredCowan you have a new issue."

      # post = HTTParty.POST("https://api.github.com/repos/JaredCowan/Ga-Cohort-Network/issues/1/comments", :headers => { "User-Agent" => usr[:username], "Authorization" => "#{token}" }, :body => { :body => final}.to_json) 
      post = HTTParty.post("https://api.github.com/repos/JaredCowan/Ga-Cohort-Network/issues/1/comments", :headers => { "User-Agent" => "VerdeCircle-Bot", "Authorization" => "token 809094b8331d415d955bb191f0dae93ab13c10ec" }, :body => { :body => "winning"}.to_json)

      puts post
    # end

    render :nothing => true
  end
end
