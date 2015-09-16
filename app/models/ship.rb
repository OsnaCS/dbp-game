class Ship < ActiveRecord::Base
   
  has_many :build_lists, dependent: :destroy
  has_many :facility_instances, dependent: :destroy
  has_many :facilities, :through => :facility_instances
  has_many :unit_instances, dependent: :destroy
  has_many :units, :through => :unit_instances
  has_one :user_ship, dependent: :destroy
  has_one :user, :through => :user_ship
  has_many :ships_stations, dependent: :destroy
  has_many :stations, :through => :ships_stations
  after_initialize :init, if: :new_record?

  def check_condition(conditions)
    condition_split = conditions.split(",")

    condition_split.each do |condition|
      condition_elements = condition.split(":")
      if(condition_elements[0].eql? "g")
        station = ShipsStation.find_by(:ship_id => self.id, :station_id => 2000 + condition_elements[1].to_i)
        if not (station.level >= condition_elements[2].to_i)
          return false
        end
      end
    end
    return true
  end

  def sum_level()
    sum=0
    ships_stations.each do |station|
      sum+=station.level
    end  
    return sum - ships_stations.find_by(station_id: 2007).level
  end

  def max_station_level()
    return 100 + 10 * ShipsStation.find_by(ship_id: self.id, station_id: 2007).level
  end

  def has_min_station_level(station, level)
    return ships_stations.find_by(:station_id => station.id).level >= level.to_i
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
            station_instance = ShipsStation.find_by(id: build.instance_id)
            station_instance.start_time = Time.now
            station_instance.save
          end
          if(typ == 'r')
            science_instance = ScienceInstance.find_by(id: build.instance_id)
            science_instance.start_time = Time.now
            science_instance.save
          end
          if(typ == 'u')
            unit_instance = UnitInstance.find_by(id: build.instance_id)
            unit_instance.start_time = Time.now
            unit_instance.save
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

    def capped_units()
    if self.build_list_count('u') >= 2
      return true
    end
    return false
  end

  def can_build(instance)
    level = instance.level
    condition = instance.check_conditions()

    metal = instance.station.get_metal_cost(level)
    crystal = instance.station.get_crystal_cost(level)
    fuel = instance.station.get_fuel_cost(level)

    enough_resources = self.user_ship.user.has_enough_resources(metal, crystal, fuel)
    return condition && !self.is_upgrading(instance) && enough_resources && !(instance.level_cap_reached) && self.enough_space(instance) && build_count_control
  end

  def build_count_control
    back = true
    ships_stations.each do |instance|
      if(self.build_lists.find_by(typeSign: 's', instance_id: instance.id) != nil)
        back = false
      end
    end
    return back
  end

  def enough_space(instance)
    if(instance.station_id == 2007)
      return true
    end

    return self.sum_level < self.max_station_level
  end

  def is_building(instance)
    typ = ''
    if(instance.is_a? UnitInstance)
      typ = 'u'
    end
    if(instance.is_a? FacilityInstance)
      typ = 'f'
    end
    return build_lists.find_by(typeSign: typ, instance_id: instance.id) != nil && instance.start_time != nil
  end

  def is_upgrading(instance)
    return self.build_lists.find_by(typeSign: 's', instance_id: instance.id) != nil && instance.start_time != nil
  end

  def get_used_energy
    scan_metal = 2 ** (self.ships_stations.find_by(station_id: '2001').level)
    scan_crystal = 2 ** (self.ships_stations.find_by(station_id: '2002').level)
    scan_fuel = 2 ** (self.ships_stations.find_by(station_id: '2003').level)
    self.used_energy = scan_metal + scan_crystal + scan_fuel
    self.save
  end

  def get_energy
    generator = 2 ** (self.ships_stations.find_by(station_id: '2014').level + 1)
    burn_generator = 2 ** (self.ships_stations.find_by(station_id: '2015').level + 1)# Generator effizienz multiplizieren
    solarpanel = 4 * self.facility_instances.find_by(facility_id: 3013).count
    self.energy = generator + burn_generator + solarpanel
    self.save
  end

  def get_collect_difference(instance, last_update)
    start = 0.0
    id = instance.station_id
    level = instance.level
    if id==2001 || id==2002
      start = 2000.0
    end
    if(id==2003)
      start = 1000.0
    end
    start /= 3600.0
    time = Time.now.getutc
    elapsed_seconds = time - last_update

    difference = (start* (1.5 ** level))*(elapsed_seconds)
    if (self.used_energy > self.energy)
      ratio = self.energy / self.used_energy
      return ratio * difference
    else
      return difference
    end
  end

  def update_resources
		ships_stations.each do |station_instance|
        if station_instance.station_id == 2001	#metal
          self.metal += get_collect_difference(station_instance, lastChecked)
          self.metal = check_storage(2008,self.metal)
          #self.metal=0
        end
        if station_instance.station_id == 2002	#cristal
          self.cristal += get_collect_difference(station_instance, lastChecked)
          self.cristal = check_storage(2009,self.cristal)
          #self.cristal=0
        end
        if station_instance.station_id == 2003	#fuel
          self.fuel += get_collect_difference(station_instance, lastChecked)
          self.fuel = check_storage(2010,self.fuel)
          #self.fuel=0
        end
	  end

    self.lastChecked = Time.now.getutc
    self.save
  end

  private
  def check_storage(id, ressource)

    if id==2008 || id==2009
      start = 10000.0
    end
    if(id==2010)
      start = 5000.0
    end
      lvl = ships_stations.find_by(station_id: id).level
      value = start * 2**lvl
      if value < ressource
        return value
      else
        return ressource
      end
  end

  def init
    self.metal = 0
    self.cristal = 0
    self.fuel = 0
    self.lastChecked = Time.now.getutc

    Station.all.each do |station|
      if not(ships_stations.exists?(:station_id => station.id, :ship_id => self.id))
        ships_stations.build(station: station, level: 0)
      end
    end

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
