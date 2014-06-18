# Load the rails application
require File.expand_path('../application', __FILE__)
#30/05/13
if ENV['RAILS_ENV'] == "production"
ActiveSupport::Deprecation.silenced = true
end
# Initialize the rails application
Myndozero::Application.initialize!
ENV['RAILS_ENV'] = 'development'
#config.gem 'typus'



