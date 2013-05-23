source 'https://rubygems.org'

platforms :ruby do
  gem 'pg'
end

platforms :jruby do
  gem 'trinidad'
  gem 'jruby-openssl'
end
gem 'sprockets'
gem 'thin'
gem 'gravatar_image_tag' 
gem 'rails' , '3.2.13'
gem 'pg' #, :group => [:development, :test]
gem 'will_paginate'
gem 'bootstrap-will_paginate'
gem 'jquery-rails'
# gem 'typus', :git => 'git://github.com/fesplugas/typus.git'
gem 'bootstrap-sass', '2.1'
gem 'bcrypt-ruby'
gem 'faker'

 group :assets do

         gem 'sass-rails',   '~> 3.2.3'
         gem 'coffee-rails', '~> 3.2.1'
         gem 'annotate'
         gem 'uglifier' #, '>= 1.0.3'
         gem 'slim-rails'
         gem 'compass-rails'

 end

group :production do
 gem 'pg'
end

group :development do
gem 'rspec-rails'
 gem 'capybara'
 gem 'webrat'
 end
  
group :test do
    gem 'capybara'
    gem 'rspec-rails'
    gem 'webrat'
    gem 'spork'
    gem 'factory_girl_rails', '1.0'
    gem 'autotest-notification'
    gem 'database_cleaner'
 end

