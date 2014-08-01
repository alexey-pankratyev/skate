# ActionMailer::Base.smtp_settings = {
#   :address        => 'smtp.sendgrid.net',
#   :port           => '587',
#   :authentication => :plain,
#   :user_name      => ENV['SENDGRID_USERNAME'],
#   :password       => ENV['SENDGRID_PASSWORD'],
#   :domain         => 'heroku.com'
# }
#  ActionMailer::Base.delivery_method = :smtp
#  ActionMailer::Base.smtp_settings  = {
#   address:              'smtp.gmail.com',
#   port:                 587,
#   domain:               'alexey.pankratev@gmail.com',
#   user_name:            'alexey.pankratev',
#   password:             'foot6good',
#   authentication:       'plain'
#    } 
# # ActionMailer::Base.default_url_options[:host] = "localhost:3000"
Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development? 
Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.production? 

  ActionMailer::Base.smtp_settings = {
   :port           => '25',
   :address        => ENV['POSTMARK_SMTP_SERVER'],
   :user_name      => ENV['POSTMARK_API_KEY'],
   :password       => ENV['POSTMARK_API_KEY'],
   :domain         => 'heroku.com',
   :authentication => :plain,
  }
  ActionMailer::Base.delivery_method = :smtp