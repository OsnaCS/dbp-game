class NotificationViewController < ApplicationController
  def index
  	@notifications = Notification.all.where(user_id: current_user.id)
  	@notes = Hash.new
  	timetype = ""
  	@notifications.each_with_index do |note, index|
  		time = (Time.now - note.created_at)
  		if time < 60
  			if time == 1
  				timetype = "Sekunde"
  			else
  				timetype = "Sekunden"
  			end
  		else
  			time = time / 60
  			timetype = "Minute"	
  			if time > 2
  				timetype = "Minuten"
  			end
  			if time > 60
	  			time = time / 60
	  			timetype = "Stunde"
	  			if time > 2
	  				timetype = "Stunden"
	  			end
	  			if time > 24
	  				time = time / 24
	  				timetype = "Tag"
	  				if time > 2
	  					timetype = "Tagen"
	  				end
	  			end
	  		end
  		end
   		@notes[index] = {note_id: note.id, message: Message.find_by_id(note.message_id).fullmes, timestamp: time, timetype: timetype}
  	end
  end
end
