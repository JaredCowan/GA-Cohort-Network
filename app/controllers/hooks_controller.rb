class HooksController < ApplicationController
  respond_to :json
  skip_before_filter  :verify_authenticity_token

  def post_callback
    usr = {:username => ENV['GH_VALUE']}
    post = HTTParty.patch("https://api.github.com/repos/JaredCowan/Ga-Cohort-Network/issues/1", :headers => { "User-Agent" => usr[:username], "Authorization" => ENV['GH_TOKEN'] }, :body => { :body => "catttssss"}.to_json) 
    # puts "status code: #{post.code}, status message: #{post.message}"
    # puts pretty(body)
    response.body = "200"
    puts request.inspect
    puts post
    render :nothing => true
  end
end
