class HomeController < ApplicationController
  before_action :authenticate_user!


  def get_json_data
  	if user_signed_in?
  		@ship = current_user.active_ship
  		@notification_count = Notification.all.where(user_id: current_user.id).count
  		@ship.update_resources

  		@metal_count = @ship.metal
  		@crystal_count = @ship.cristal
  		@fuel_count = @ship.fuel
  		
  		respond_to do |format|
    		format.html 
    		format.json { render :json => { :msg => @notification_count, :metal => @metal_count, :crystal => @crystal_count, :fuel => @fuel_count } }
  		end
    end
  end
end
