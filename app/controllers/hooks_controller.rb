class HooksController < ApplicationController
  respond_to :html, :json

  def post_callback
    usr = {:username => ENV['GH_VALUE']}
    post = HTTParty.post("https://api.github.com/repos/JaredCowan/Ga-Cohort-Network/issues/1", :headers => { "User-Agent" => usr[:username], "Authorization" => ENV['GH_TOKEN'] }, :body => { :body => "catttssss"}.to_json) 
    # puts "status code: #{post.code}, status message: #{post.message}"
    # puts pretty(body)
    puts request.inspect
    render :nothing => true
  end
end
