class Ship < ActiveRecord::Base
  
  has_one :user_ship
  has_one :user, :through => :user_ships
  has_many :ships_stations
  has_many :stations, :through => :ships_stations
  after_initialize :create_stations, if: :new_record?

  def update_resources
  	last_checked = self.lastChecked
		self.ships_stations.each do |station|
        if station.station_id == 1	#metal
          self.metal += get_collect_difference(station.level, station.station_id, last_checked)
          #self.metal=0
        end
        if station.station_id == 2	#cristal
          self.cristal += get_collect_difference(station.level, station.station_id, last_checked)
          #self.cristal=0
        end
        if station.station_id == 3	#fuel
          self.fuel += get_collect_difference(station.level, station.station_id, last_checked)
          #self.fuel=0
        end
	end
    
    self.lastChecked = Time.now.getutc
    self.save
    
  end

  

  private
  def create_stations
    Station.all.each do |station|
      self.ships_stations.build(ship: self, station: station, level: station.initial_level)
      end
      self.metal=0
      self.cristal=0
      self.fuel=0
      self.lastChecked = Time.now.getutc
      return self.id
  end

  private
  def get_collect_difference(level, id, last_update)
  	if id==1 || id==2
  		start = 2000.0
    end
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

 
end
