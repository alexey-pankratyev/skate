namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
   make_users
   make_microposts
   make_relationships
   make_direct_messages
  end
end

def make_users 
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "Alexey",
                 :nickname => "rezter",
                 :email => "alexey.pankratev@gmail.com",
                 :password => "foobar",
                 :password_confirmation => "foobar")
    admin.toggle!(:admin)
 
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      nickname = "nick#{n+1}"
      password  = "password"
      User.create!(name: name,
                   nickname: nickname,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
end

def make_microposts
    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end

def make_direct_messages
  users = User.all(limit: 6)
        50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end
end
