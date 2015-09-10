class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
  	if current_user.activeShip == nil
      redirect_to :controller => 'ships', :action => 'new'
   	end
  end

  def get_json_data
  	if user_signed_in?
  		@ship = Ship.find_by_id(current_user.activeShip)
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
