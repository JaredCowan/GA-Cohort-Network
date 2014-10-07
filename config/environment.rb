# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

APP_CONFIG = YAML.load_file("#{Rails.root}/config/config.yml")
# http://davidlesches.com/blog/elegant-titles-and-seo-meta-tags-in-rails
ActiveRecord::Base.logger.level = Logger::DEBUG