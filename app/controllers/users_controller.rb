 #!/bin/env ruby
# encoding: utf-8
 class UsersController < ApplicationController
  
 before_filter :signed_in_user, only: [:index, :edit, :update, :destroy ]
 before_filter :correct_user,   only: [:edit, :update]
 before_filter :admin_user,     only: :destroy
 
   def index 
      @title = "All users"
      @users = User.paginate(page: params[:page])
   end

   def show
      @user = User.find(params[:id])
      @microposts = @user.microposts.paginate(page: params[:page])
      @title = @user.name
   end
  
   def new
      @user = User.new
      @title = "Sign up"
   end

  def create 
     @user = User.new(params[:user]) 
    if @user.save
     sign_in @user
     flash[:success] = "Welcome"
     redirect_to @user
    else
     @title = "Sign up"
     @user.password.clear
     @user.password_confirmation.clear
     render 'new'
     end
  end

  def edit
      @user = User.find(params[:id])
      @title = @user.name
  end

   def update
      @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end    
   end


 
  def destroy

    user = User.find(params[:id])
    unless current_user?(user)
      user.destroy
      flash[:success] = "User destroyed."
    else 
      flash[:error] = "No can't destroy admin!"
    end
    redirect_to users_path
  end

 
 private
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

   
end

 