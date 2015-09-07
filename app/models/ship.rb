class Ship < ActiveRecord::Base

  has_many :ships_stations
  has_many :stations, :through => :ships_stations
  after_initialize :create_stations, if: :new_record?

  public
  def update_resources
  	last_checked = self.lastChecked
		self.ships_stations.each do |station|
        if station.station_id == 1	#metal
          self.metal = get_collect_difference(20, station.station_id, last_checked)
        end
        if station.station_id == 2	#cristal
          self.cristal += get_collect_difference(20, station.station_id, last_checked)
        end
        if station.station_id == 3	#fuel
          self.fuel += get_collect_difference(20, station.station_id, last_checked)
        end
	end
    
    self.lastChecked = Time.now.getutc
    self.save
    
  end

  private
  def create_stations
    Station.all.each do |station|
      self.ships_stations.build(ship: self, station: station, level: station.initial_level)
      self.metal=0
      self.cristal=0
      self.fuel=0
      self.lastChecked = Time.now.getutc
    end
  end


private
def get_collect_difference(level, id, last_update)
  	if id==1 || id==2 || id==3
  		start = 2000.0
  		
  		if(id==3) 
  			start = 1000.0
		end
		start /= 3600.0
		time = Time.now.getutc
		start = start.to_f
		elapsed_seconds = time - last_update
		produktion = (start* (1.5 ** level))*(elapsed_seconds)
		return produktion
  	end
  	return 0
  end

 
end
