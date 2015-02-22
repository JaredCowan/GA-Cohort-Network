class HookController < ApplicationController
  def comment
    usr = {:username => ENV['GH_VALUE']}
    HTTParty.post(ENV['URL'], :headers => { "User-Agent" => usr[:username], "Authorization" => ENV['GA_TOKEN'] }, :body => { :body => "testing thiissss"}.to_json) 
    # puts "status code: #{post.code}, status message: #{post.message}"
    # puts pretty(body)
  end
end
