class Ship < ActiveRecord::Base

  has_many :facility_instances, dependent: :destroy
  has_many :facilities, :through => :facility_instances
  has_one :user_ship
  has_one :user, :through => :user_ship
  has_many :ships_stations
  has_many :stations, :through => :ships_stations
  after_initialize :create_stations, if: :new_record?
  after_initialize :create_units
  after_initialize :init

  def check_condition(conditions)
    condition_split = conditions.split(",")

    condition_split.each do |condition|
      condition_elements = condition.split(":")
      if(condition_elements[0].eql? "s")
        station = ShipsStation.find_by(:ship_id => self.id, :station_id => 2000 + condition_elements[1].to_i)
        if not (station.level >= condition_elements[2].to_i)
          return false
        end
      end
    end
    return true
  end

  def building_capped()
    if self.is_building >= 1
      return true
    end
    return false
  end

  def is_building()
    count = 0
    facility_instances.each do |instance|
      if not(instance.start_time.nil?)
        count += 1
      end
    end
    return count
  end

  def update_resources
  	last_checked = self.lastChecked
		self.ships_stations.each do |station|
        if station.station_id == 2001	#metal
          self.metal += get_collect_difference(station.level, station.station_id, last_checked)
          self.metal=check_storage(2008,self.metal)
          #self.metal=0
        end
        if station.station_id == 2002	#cristal
          self.cristal += get_collect_difference(station.level, station.station_id, last_checked)
          self.cristal=check_storage(2009,self.cristal)
          #self.cristal=0
        end
        if station.station_id == 2003	#fuel
          self.fuel += get_collect_difference(station.level, station.station_id, last_checked)
          self.fuel=check_storage(2010,self.fuel)
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
  def check_storage(id, ressource)

    if id==2008 || id==2009
      start = 10000.0
    end
    if(id==2010)
      start = 5000.0
    end
      lvl = ShipsStation.find_by(ship_id: self, station_id: id).level
      value = start * 2**lvl
      if value < ressource
        return value
      else
        return ressource
      end
    else    
      return ressource
    
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

  def init
    Facility.all.each do |facility|
      if not(facility_instances.exists?(:facility_id => facility.id, :ship_id => self.id))
        facility_instances.build(facility: facility, count: 0)
      end
    end
  end

end
