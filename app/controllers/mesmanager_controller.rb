class MesmanagerController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def addmessage
  	
  	@message = params[:message_id]
  	current_user.notifications.create(message: Message.find_by_code(@message))

  end

end
