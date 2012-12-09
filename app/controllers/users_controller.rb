class UsersController < ApplicationController
  
   def show
    @user = User.find(params[:id])
    @title = @user.name
  end
  
  def new
    @user = User.new
    @title = "Sing up"
  end

  def create 
    @user = User.new(params[:user]) 
    if @user.save
    # Обработка успешного сохранения.
    else
    @title = "Sign up"
    render 'new'
    end
  end

end

