class DirectMessagesController < ApplicationController

 
  before_filter :signed_in_user

  def received

  	@user= DirectMessage.where(["recipient_id = ?", current_user]) 
    @direct_messages = @user.paginate(page: params[:page])
     
      
  end

  def sent

    @user = DirectMessage.where(["sender_id = ?", current_user])
    @direct_messages = @user.paginate(page: params[:page])
  end

end
