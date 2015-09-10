class NotificationViewController < ApplicationController
  before_action :authenticate_user!

  def index
  	@notifications = Notification.all.where(user_id: current_user.id)
  	@notes = Hash.new
  	@notifications.each_with_index do |note, index|
  		@notes[index] = {note_id: note.id, message: Message.find_by_id(note.message_id).mes, timestamp: note.created_at}
  	end
  end
end
