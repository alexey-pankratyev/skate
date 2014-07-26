
FactoryGirl.define do
  
  factory :user do 
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:nickname)  { |n| "Person#{n}" }
    sequence(:email) { |n| "person_#{n}@yandex.ru"}
    password "foobar"
    password_confirmation "foobar"
    state "active"

    factory :admin do
      admin true
    end
  end

  factory :micropost do
    content "Lorem ipsum"
    user
  end

  factory :userToReplyTo, class: User do | user |
     user.name "Donald Duck"
     user.state   "active"
     user.nickname "donald"
     user.email "donald@entenhausen.de"
     user.password "foobar"
     user.password_confirmation "foobar"
   end   

end