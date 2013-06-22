class PagesController < ApplicationController
include ApplicationHelper

  def home
    # @title = "Home"
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
