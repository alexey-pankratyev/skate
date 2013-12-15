
FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:nickname)  { |n| "Test#{n}" }
    sequence(:email) { |n| "person_#{n}@yandex.ru"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :userToReplyTo, class: User do | user |
    user.name "Donald Duck"
    user.nick "donald"
    user.email "donald@entenhausen.de"
    user.password "foobar"
    user.password_confirmation "foobar"
  end 

  factory :micropost do
    content "Lorem ipsum"
    user
  end
  
end