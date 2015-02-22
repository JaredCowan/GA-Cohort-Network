class HookController < ApplicationController
  def comment()
    usr = {:username => ENV['GH_VALUE']}
    post = HTTParty.post(URL,
                        :headers => { "User-Agent" => usr[:username], "Authorization" => ENV['GA_TOKEN']
                                    },
                        :body    => { :body => "testing thiissss"
                                    }.to_json
                      )
    # body = JSON.parse(post.body)
    # puts "status code: #{post.code}, status message: #{post.message}"
    # puts pretty(body)
    render :nothing => true
  end
end
