class Ship < ActiveRecord::Base

  has_one :user_ship
  has_one :user, :through => :user_ships
  has_many :ships_stations
  has_many :stations, :through => :ships_stations
  after_initialize :create_stations, if: :new_record?
  after_initialize :create_units

  def update_resources
  	last_checked = self.lastChecked
		self.ships_stations.each do |station|
        if station.station_id == 2001	#metal
          self.metal += get_collect_difference(station.level, station.station_id, last_checked)
          #self.metal=0
        end
        if station.station_id == 2002	#cristal
          self.cristal += get_collect_difference(station.level, station.station_id, last_checked)
          #self.cristal=0
        end
        if station.station_id == 2003	#fuel
          self.fuel += get_collect_difference(station.level, station.station_id, last_checked)
          #self.fuel=0
        end
	  end

    self.lastChecked = Time.now.getutc
    self.save
  end

  def get_unit_instance(unit)
    return UnitInstance.find_by(:unit_id => unit.id, :ship_id => self.id)
  end

  def is_upgrading()
    ships_stations.each do |station|
      if not(station.start_time.nil?)
        return true
      end
    end
    return false
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

  def create_units
    if(self.id.nil?)
      return
    else
      Unit.all.each do |unit|
        if not(UnitInstance.exists?(:unit_id => unit.id, :ship_id => self.id))
          instance = UnitInstance.new
          instance.unit_id = unit.id
          instance.ship_id = self.id
          instance.amount = 0;
          instance.save
        end
      end
    end
  end

  private
  def get_collect_difference(level, id, last_update)
  	if id==2001 || id==2002
  		start = 2000.0
    end
  	if(id==2003)
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
