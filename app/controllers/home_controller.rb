class HomeController < ApplicationController
  before_action :authenticate_user!

  def get_json_data
    if user_signed_in?
      @ship = current_user.active_ship
      @notification_count = Notification.all.where(user_id: current_user.id).count
      @ship.update_resources
      @ship.get_used_energy
      @ship.get_energy
      @metal_count = @ship.metal.to_i
      @crystal_count = @ship.cristal.to_i
      @fuel_count = @ship.fuel.to_i
      @energy_count = @ship.used_energy
      @metal_storage_cap = @ship.max_storage(2008).to_i
      @crystal_storage_cap = @ship.max_storage(2009).to_i
      @fuel_storage_cap = @ship.max_storage(2010).to_i
      @energy_max = @ship.energy;

      colorbool = false
      if(@energy_count > @energy_max)
        colorbool = true
      end

      @metal_count_s = @metal_count.to_s + "/" + @metal_storage_cap.to_s
      @crystal_count_s = @crystal_count.to_s + "/" + @crystal_storage_cap.to_s
      @fuel_count_s = @fuel_count.to_s + "/" + @fuel_storage_cap.to_s
      @energy_count_s = @energy_count.to_s + "/" + @energy_max.to_s
      respond_to do |format|
        format.html
        format.json { render :json => { :msg => @notification_count, :metal => @metal_count_s, :crystal => @crystal_count_s, :fuel => @fuel_count_s, :energy => @energy_count_s, :energy_color => colorbool } }
      end
    end
  end
end
