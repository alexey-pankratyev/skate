class DirectMessagesController < ApplicationController

 
  before_filter :signed_in_user


     

  def received
  	   
     @direct_messages = DirectMessage.where(["recipient_id = ?", current_user])
      
  end

  def sent

    @direct_messages = DirectMessage.where(["sender_id = ?", current_user])

  end

  


end
