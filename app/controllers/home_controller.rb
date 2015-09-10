class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
  	if current_user.activeShip == nil
      redirect_to :controller => 'ships', :action => 'new'
   	end
  end

  def get_json_data
  	if user_signed_in?
  		@notification_count = Notification.all.where(user_id: current_user.id).count
  		respond_to do |format|
    		format.html 
    		format.json { render :json => { :msg => @notification_count } }
  		end
    end
  end
end
