class DirectMessagesController < ApplicationController
  
  attr_accessor :use, :recipient, :sender 
  before_filter :signed_in_user

  def received
  	@user= DirectMessage.where(["recipient_id = ?", current_user]) 
    @direct_messages = @user.paginate(page: params[:page])
    @use="sender"
  end

  def sent
    @user = DirectMessage.where(["sender_id = ?", current_user])
    @direct_messages = @user.paginate(page: params[:page])
  end

end
