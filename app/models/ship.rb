class Ship < ActiveRecord::Base

  has_many :build_lists, dependent: :destroy
  has_many :facility_instances, dependent: :destroy
  has_many :facilities, :through => :facility_instances
  has_many :unit_instances, dependent: :destroy
  has_many :units, :through => :unit_instances
  has_one :user_ship
  has_one :user, :through => :user_ship
  has_many :ships_stations
  has_many :stations, :through => :ships_stations
  after_initialize :create_stations, if: :new_record?
  after_initialize :init, if: :new_record?

  def sum_level
    sum=0
    ShipsStation.where(:ship_id => self.id).each do |station|
      sum+=station.level
    end
    return sum - ShipsStation.find_by(ship_id: self.id, station_id: 2007).level
  end

  def max_station_level
    i = 100 + 10 * ShipsStation.find_by(ship_id: self.id, station_id: 2007).level
    return i
  end
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

  def update_builds(typeString = 'f,s,r,u')
    type_split = typeString.split(",")
    type_split.each do |typ|
      build_lists.each do |build|
        if (build.typeSign == typ)
          if(typ == 'f')
            facility_instance = FacilityInstance.find_by(id: build.instance_id)
            facility_instance.start_time = Time.now
            facility_instance.save
          end
          if(typ == 's')
          end
          if(typ == 'r')
          end
          if(typ == 'u')
          end
        end
      end
    end
  end

  def build_list_count(typeString)
    count = 0
    build_lists.each do |instance|
      if instance.typeSign == typeString
        count += 1
      end
    end
    return count
  end

  def capped_facilities()
    if self.build_list_count('f') >= 2
      return true
    end
    return false
  end

  def is_building(instance)
    return build_lists.find_by(instance_id: instance.id) != nil && instance.start_time != nil
  end

  def get_used_energy
    scan_metal = ((self.ships_stations.find_by(station_id: '2001').energy_usage.to_f / 100) * 2 ** (self.ships_stations.find_by(station_id: '2001').level)).to_i
    scan_crystal = ((self.ships_stations.find_by(station_id: '2002').energy_usage.to_f / 100) * 2 ** (self.ships_stations.find_by(station_id: '2002').level)).to_i
    scan_fuel = ((self.ships_stations.find_by(station_id: '2003').energy_usage.to_f / 100) * 2 ** (self.ships_stations.find_by(station_id: '2003').level)).to_i
    self.used_energy = scan_metal + scan_crystal + scan_fuel
    self.save
  end

  def get_energy
    generator = 2 ** (self.ships_stations.find_by(station_id: '2014').level + 1)
    if (self.fuel > 0)
      burn_generator = ((self.ships_stations.find_by(station_id: '2015').energy_usage.to_f / 100) * 2 ** (self.ships_stations.find_by(station_id: '2015').level + 1)).to_i
    else
      burn_generator = 0
    end
    solarpanel = 4 * self.facility_instances.find_by(facility_id: 3013).count
    self.energy = generator + burn_generator + solarpanel
    self.save
  end

  def update_resources
  	last_checked = self.lastChecked
		self.ships_stations.each do |station|
        if station.station_id == 2001	#metal
          self.metal += get_collect_difference(station.level, station.station_id, last_checked, station.energy_usage)
          self.metal=check_storage(2008,self.metal)
          #self.metal=0
        end
        if station.station_id == 2002	#cristal
          self.cristal += get_collect_difference(station.level, station.station_id, last_checked, station.energy_usage)
          self.cristal=check_storage(2009,self.cristal)
          #self.cristal=0
        end
        if station.station_id == 2003	#fuel
          self.fuel += get_collect_difference(station.level, station.station_id, last_checked, station.energy_usage)
          self.fuel=check_storage(2010,self.fuel)
          #self.fuel=0
        end
        if station.station_id == 2015 #burn_generator
          current_fuel = self.fuel - get_collect_difference(station.level, station.station_id, last_checked, station.energy_usage)
          if (current_fuel > 0)
            self.fuel = current_fuel
          else
            self.fuel = 0
            self.energy -= ((self.ships_stations.find_by(station_id: '2015').energy_usage.to_f / 100) * 2 ** (self.ships_stations.find_by(station_id: '2015').level + 1)).to_i
          end
        end
	  end
    self.lastChecked = Time.now.getutc
    self.save
  end

  def update_metal(value)
    self.metal+=value
    self.metal=check_storage(2008,self.metal)
    return self.metal
  end

  def update_cristal(value)
    self.cristal+=value
    self.cristal=check_storage(2009,self.cristal)
    return self.cristal
  end

  def update_fuel(value)
    self.fuel+=value
    self.fuel=check_storage(2010,self.fuel)
    return self.fuel
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

  def max_storage(id)
    if id==2008 || id==2009
      start = 10000.0
    end
    if(id==2010)
      start = 5000.0
    end
    lvl = ShipsStation.find_by(ship_id: self, station_id: id).level
    value = start * 2**lvl
    return value
  end

  private
  def create_stations
    Station.all.each do |station|
      self.ships_stations.build(ship: self, station: station, level: station.initial_level)
      end
      self.metal=4000
      self.cristal=4000
      self.fuel=2000
      self.lastChecked = Time.now.getutc
      return self.id
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
  end

  private
  def get_collect_difference(level, id, last_update, energy_usage)
  	if id==2001 || id==2002
  		start = 2000.0
    end
  	if(id==2003)
  		start = 1000.0
		end
    if(id==2015)
      start= 500.0
    end
		start /= 3600.0
		time = Time.now.getutc
		start = start.to_f
		elapsed_seconds = time - last_update
    if (self.used_energy > self.energy)
      diff = 1/(self.used_energy - self.energy).to_f
      produktion = (energy_usage / 100)  * diff * (start* (1.5 ** level))*(elapsed_seconds)
      return produktion
    else
		  produktion = (energy_usage / 100) * (start * (1.5 ** level))*(elapsed_seconds)
		  return produktion
    end
  end

  def init
    Facility.all.each do |facility|
      if not(facility_instances.exists?(:facility_id => facility.id, :ship_id => self.id))
        facility_instances.build(facility: facility, count: 0)
      end
    end
    Unit.all.each do |unit|
      if not(unit_instances.exists?(:unit_id => unit.id, :ship_id => self.id))
        unit_instances.build(unit: unit, amount: 0)
      end
    end
  end
end
