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
      @metal_storage_cap = @ship.max_storage(2008).to_i
      @crystal_storage_cap = @ship.max_storage(2009).to_i
      @fuel_storage_cap = @ship.max_storage(2010).to_i
  		
      @metal_count_s = @metal_count.to_s + "/" + @metal_storage_cap.to_s
      @crystal_count_s = @crystal_count.to_s + "/" + @crystal_storage_cap.to_s
      @fuel_count_s = @fuel_count.to_s + "/" + @fuel_storage_cap.to_s

  		respond_to do |format|
    		format.html 
    		format.json { render :json => { :msg => @notification_count, :metal => @metal_count_s, :crystal => @crystal_count_s, :fuel => @fuel_count_s } }
  		end
    end
  end
end
