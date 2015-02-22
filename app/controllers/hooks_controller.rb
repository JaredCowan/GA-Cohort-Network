class HooksController < ApplicationController
  respond_to :json
  skip_before_filter  :verify_authenticity_token

  def post_callback
    request.body.rewind
    payload = JSON.parse(request.body.read)
    action = "#{payload['action']}"
    number = "#{payload['number']}"
    $name = ENV['verdebotname']
    $token = ENV['verdebottoken']
    $bot = "#{payload['comment']['user']['login']}"
    # if action == "created"
    #   comment = payload['comment']


    #   usr = {:username => ENV['GH_VALUE']}
    #   issuebody = %(<a href="#"><img src="http://www.codereviewhub.com/site/github-approved-avatar.png" align="left" height="34" width="246"><img src='https://avatars.githubusercontent.com/u/7110664?v=3' width=34 height=34></a>) 
    #   post = HTTParty.post("https://api.github.com/repos/JaredCowan/Ga-Cohort-Network/issues/1/comments", :headers => { "User-Agent" => usr[:username], "Authorization" => ENV['GH_TOKEN'] }, :body => { :body => issuebody}.to_json) 
    # end
    puts "#{$bot}" == "VerdeCircle-Bot"
    if $bot != "VerdeCircle-Bot"
      usr = {:username => "#{$name}"}
      issuebody = payload['issue']['body']
      addon = %(<a href="#"><img src="http://www.codereviewhub.com/site/github-approved-avatar.png" align="left" height="34" width="246"><img src='https://avatars.githubusercontent.com/u/7110664?v=3' width=34 height=34></a>) 

      final = "#{issuebody} \r\n #{addon} \r\n @JaredCowan you have a new issue." +
      "This is a fully automated comment."

      test = <<-STRING
#{issuebody} \r\n #{addon}
@JaredCowan, a new issue has been posted.

(Please note that this is a [fully automated](https://github.com/VerdeCircle-Bot) comment.)

STRING

      # post = HTTParty.POST("https://api.github.com/repos/JaredCowan/Ga-Cohort-Network/issues/1/comments", :headers => { "User-Agent" => usr[:username], "Authorization" => "#{token}" }, :body => { :body => final}.to_json) 
      post = HTTParty.post("https://api.github.com/repos/VerdeCircle/VerdeCircleFrontEnd/issues/#{number}/comments", :headers => { "User-Agent" => "#{$name}", "Authorization" => "#{$token}", "Accept" => "application/vnd.github.sersi-preview+json" }, :body => { :body => "#{test}"}.to_json)

      puts payload['comment']['user']['login']
    end

    render :nothing => true
  end
end
