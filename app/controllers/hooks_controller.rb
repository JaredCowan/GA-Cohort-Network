class HooksController < ApplicationController
  respond_to :json
  skip_before_filter  :verify_authenticity_token

  def post_callback
    request.body.rewind
    payload = JSON.parse(request.body.read)
    action = "#{payload['action']}"
    number = "#{payload['issue']['number']}"
    url = "#{payload['issue']['html_url']}"
    user = "#{payload['issue']['user']['login']}"
    count = "#{payload['issue']['comments']}"
    $name = ENV['verdebotname']
    $token = ENV['verdebottoken']
    $bot = "#{payload['comment']['user']['login']}"

    puts "#{$bot}" == "VerdeCircle-Bot"
    puts count.to_i <= 1
    if $bot != "VerdeCircle-Bot" && count.to_i <= 1
      usr = {:username => "#{$name}"}
      issuebody = payload['issue']['body']
      addon = %(<a href="#"><img src="http://www.codereviewhub.com/site/github-approved-avatar.png" align="left" height="34" width="246"><img src='https://avatars.githubusercontent.com/u/7110664?v=3' width=34 height=34></a>) 

      final = "#{issuebody} \r\n #{addon} \r\n @JaredCowan you have a new issue." +
      "This is a fully automated comment."

      test = <<-STRING
> <a href="#{url}"><img src='https://avatars.githubusercontent.com/u/7110664?v=3' width=34 height=34></a> Hello! I'm the [**VerdeCircle-Bot**](https://github.com/VerdeCircle-Bot). Just here to speak on behalf of Jared.

Thanks, @#{user}! This has been added to the task list.

I'm going to tag **@JaredCowan** so he can make sure to receive this.

(Please note that this is a [**fully automated**](https://github.com/VerdeCircle-Bot) comment.)

STRING

      # post = HTTParty.POST("https://api.github.com/repos/JaredCowan/Ga-Cohort-Network/issues/1/comments", :headers => { "User-Agent" => usr[:username], "Authorization" => "#{token}" }, :body => { :body => final}.to_json) 
      post = HTTParty.post("https://api.github.com/repos/VerdeCircle/VerdeCircleFrontEnd/issues/#{number}/comments", :headers => { "User-Agent" => "#{$name}", "Authorization" => "#{$token}", "Accept" => "application/vnd.github.sersi-preview+json" }, :body => { :body => "#{test}"}.to_json)

      puts payload['comment']['user']['login']
    end

    render :nothing => true
  end
end
