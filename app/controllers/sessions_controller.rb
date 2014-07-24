class SessionsController < ApplicationController

    def new
        @title = "Sign in"
    end
  
#    force_ssl

    def create
        @title = "Sign in"
        user = User.find_by_email(params[:email].downcase)
     if user && user.authenticate(params[:password])   
        
      if user.state == "inactive"
        flash[:error] = "Your account isn't confirmed. Please check your email."
        redirect_to root_url
      else
        sign_in user
        redirect_back_or user
       # Sign the user in and redirect to the user's show page.
      end
     else
      flash.now[:error] = "Invalid email/password combination."
      render 'new'
     end
    end

    def destroy
        sign_out
        redirect_to root_path
    end

end
