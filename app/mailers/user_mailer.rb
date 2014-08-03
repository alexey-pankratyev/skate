#!/bin/env ruby
# encoding: utf-8

class UserMailer < ActionMailer::Base
	
  default from: "av.pankratev@tensor.ru"

  def welcome_email(user) 
    @user = user
    @url  = 'https://mynda.herokuapp.com/signin'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def follower_notification(followed, follower)
    @followed, @follower = followed, follower
    mail(to: @followed.email, subject: "Follower notification")
  end

  def password_reset(user)
   @user = user
   mail to: user.email, subject: "Password Reset"
  end

  def signup_confirmation(options)
     @confirmation_uri =
       "http://#{options[:host]}#{ confirm_user_path(options[:token]) }"
     mail(to: options[:email], subject: "signup confirmation", host: options[:domain])
  end

end
 