namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "Alexey",
                 :email => "alexey.pankratev@gmail.com",
                 :password => "1q2w3e4r",
                 :password_confirmation => "1q2w3e4r")
    admin.toggle!(:admin)
    99.times do |n|
      name  = Faker::Name.name
      email = "test-#{n+1}@mail.ru"
      password  = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
  end
end
