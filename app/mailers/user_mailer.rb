class UserMailer < ActionMailer::Base
  default from: "alexey.pankratev@gmail.com"

  def welcome_email(user)
    @user = user
    @url  = 'https://mynda.herokuapp.com/signin'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

end
