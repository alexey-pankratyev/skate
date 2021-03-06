class PagesController < ApplicationController

include ApplicationHelper

  def home
    # @title = "Home"
   if signed_in?
    @micropost = current_user.microposts.build 
    @feed_items = current_user.feed.paginate(page: params[:page])
   end
  end
  
  def help
    @title = "Help"  
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end

  def reviews
    @title = "Reviews"
  end

  def email
    @title = "Email"
  end
  
end
