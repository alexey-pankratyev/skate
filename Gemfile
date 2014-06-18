source 'https://rubygems.org'

ruby "1.9.3"  




gem "mail"

gem 'sprockets'
gem 'launchy'
#gem 'thin'
gem 'gravatar_image_tag' 
gem 'rails' , '3.2.13'
gem "pg" #, "~> 0.17.1"
gem 'will_paginate'#, '3.0.3'
gem 'bootstrap-will_paginate', '0.0.6'
gem 'jquery-rails'
# gem 'typus', :git => 'git://github.com/fesplugas/typus.git'
gem 'bootstrap-sass' , '2.1'
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'faker', '1.0.1'
gem 'slim-rails'
gem 'compass-rails'
gem 'russian', '~> 0.6.0'
gem 'nokogiri', '~> 1.6.0'

# Гемы, используемые только для ресурсов и не требуемые
# в среде production по умолчанию.
group :assets do
  gem 'sass-rails',   "~> 3.2.3"
  gem 'coffee-rails', "~> 3.2.1"
  gem 'uglifier'
end

group :production do

# gem 'pg'
end

group :development, :test  do
 gem 'rspec-rails', '2.13.1'
 gem 'guard-spork', '1.5.0'
 # gem 'spork', '0.9.0.rc8'
 # gem 'spork-rails', '4.0.0'
 gem 'spork', '0.9.2'
 gem 'guard-rspec', '2.5.0'
 gem 'webrat'
 gem 'capybara'
end

group :development do
  gem 'annotate', '2.5.0'
end

group :test do
 gem 'rb-inotify'
 gem 'libnotify', '0.5.9'
 gem 'factory_girl_rails', '4.1.0'
 gem 'autotest-notification'
 gem 'cucumber-rails', '1.2.1', :require => false
 gem 'database_cleaner', '0.7.0'
end




