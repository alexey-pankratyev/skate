# ActionMailer::Base.smtp_settings = {
#   :address        => 'smtp.sendgrid.net',
#   :port           => '587',
#   :authentication => :plain,
#   :user_name      => ENV['SENDGRID_USERNAME'],
#   :password       => ENV['SENDGRID_PASSWORD'],
#   :domain         => 'heroku.com'
# }

 
 # ActionMailer::Base.delivery_method = :smtp
 # ActionMailer::Base.smtp_settings  = {
 #  address:              "smtp.gmail.com",
 #  port:                 "587",
 #  #domain:               'gmail.com',
 #  user_name:            "alexey.pankratev",
 #  password:             ENV['SMTP_PASSWORD'],
 #  authentication:       "plain",
 #  enable_starttls_auto:  true
 #   } 

 ActionMailer::Base.delivery_method = :smtp
 ActionMailer::Base.smtp_settings  = {
  address:              'corpmail.tensor.ru',
  port:                 587,
  domain:               'tensor.ru',
  user_name:            'av.pankratev@tensor.ru',
  password:             'hudCkzW3',
  authentication:       'plain',
  enable_starttls_auto: true  } 

 ActionMailer::Base.default_url_options[:host] = "localhost:3000"
 Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development? 


#   ActionMailer::Base.delivery_method = :smtp
#   ActionMailer::Base.smtp_settings = {
#    port: '25',
#    address: ENV['POSTMARK_SMTP_SERVER'],
#    user_name: ENV['POSTMARK_API_KEY'],
#    password: ENV['POSTMARK_API_KEY'],
#    domain: 'mynda.heroku.com',
#    authentication: :plain,
#    enable_starttls_auto: true
#   }


