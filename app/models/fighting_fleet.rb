class FightingFleet < ActiveRecord::Base
  @@missions = {1 => "Angriff", 2 => "Transport", 3 => "Stationieren"}
  @@state = {1 => "Hinflug", 2 => "Rückflug"}

  belongs_to :user
  belongs_to :expedition
  belongs_to :fight 
  has_many :ship_groups, dependent: :destroy

  validates :id, uniqueness: true
 
#  validates :number, :numericality => { :greater_than_or_equal_to =>0 }
  accepts_nested_attributes_for :fight
  accepts_nested_attributes_for :ship_groups

  after_initialize :initialize_units, if: :new_record?
#  before_create :create_units

  def initialize_units
   # if self.new_record? 
    #  self.build_fight
   # end  
    if self.ship_groups.empty?
      Unit.all.each do|u| 
        self.ship_groups.build  unit: u, number: 0
      end
    end
  end

  def self.mission
    return @@missions
  end

  def self.static_flight_duration(start_ship, end_ship, total_speed)
    distance = start_ship.user.distance_to(end_ship.user)

    time = 20 + (distance / (total_speed * 10))
    return time.to_i
  end

  def flight_duration(start_ship, end_ship)
    distance = start_ship.user.distance_to(end_ship.user)

    time = 20 + (distance / (self.get_total_speed * 10))
    return time.to_i
  end

  def empty
    return self.get_ship_amount == 0
  end

  def get_time_since_start
    return (Time.now - self.start_time).to_i
  end

  def get_state
    return @@state[self.state]
  end

  def get_mission
    return @@missions[self.mission]
  end

  def get_total_speed
    min = 1000
    self.ship_groups.each do |group|
      if(group.unit.speed < min && group.number != 0)
        min = group.unit.speed
      end
    end
    return min
  end

  def get_data
    return self.data.split(",")
  end

  def get_target_ship
    return Ship.find_by(:id => self.get_data[1].to_i)
  end

  def set_data(index, data)
    old_data = self.get_data
    old_data[index] = data
    newData = ""

    first = true
    old_data.each do |d|
      if(first)
        newData = d
        first = false
      else
        newData = newData + "," + d
      end
    end
    self.data = newData
    self.save
  end

  def clear_cargo
    self.set_data(0, "0:0:0")
  end

  def set_cargo(metal, crystal, fuel)
    self.set_data(0, metal.to_i.to_s + ":" + crystal.to_i.to_s + ":" + fuel.to_i.to_s)
  end

  def get_ship_amount
    number = 0
    self.ship_groups.each do |group|
      number += group.number
    end
    return number
  end

  def clear_fleet
    self.ship_groups.each do |group|
      group.number = 0
      group.save
    end
  end

  def get_metal_cargo
    return self.get_data[0].split(":")[0].to_i
  end

  def get_fuel_cargo
    return self.get_data[0].split(":")[2].to_i
  end

  def get_crystal_cargo
    return self.get_data[0].split(":")[1].to_i
  end

  def get_start_ship
    return Ship.find_by(:id => self.start_ship)
  end

  def info
    back = "Schiffe der Flotte: <br>"
    self.ship_groups.each do |group|
      if(group.number != 0)
        back = back + "- " + group.number.to_s + " " + group.unit.name + "<br>"
      end
    end
    back = back + "<br>"
    res_data = self.get_data[0].split(":")

    if(res_data.length == 3)
      back = back + "- Verladenes Metall: " + res_data[0] + "<br>"
      back = back + "- Verladene Kristalle: " + res_data[1] + "<br>"
      back = back + "- Verladener Treibstoff: " + res_data[2] + "<br>"
    end

    return back.html_safe
  end

  def create_units
  end

  def update_time(format)
    if(self.start_time) 
      one_way_duration = self.flight_duration(self.get_start_ship, self.get_target_ship)
      rest_time = one_way_duration - self.get_time_since_start

      if(rest_time <= 0)
        if(self.state == 1)
          case self.mission
            when 1
              self.fight.fight(self.id, self.get_target_ship.id)
            when 2
              #Wenn Resourcenlimit erreicht, dann kein Transfer => Bug
              target_ship = self.get_target_ship
              metal = self.get_metal_cargo
              crystal = self.get_crystal_cargo
              fuel = self.get_fuel_cargo

              dm = (target_ship.max_storage(2008) - target_ship.metal) - metal
              if(dm < 0)
                dm = -1 * dm
              else
                dm = 0
              end

              dc = (target_ship.max_storage(2009)- target_ship.cristal) - crystal
              if(dc < 0)
                dc = -1 * dc
              else
                dc = 0
              end

              df = (target_ship.max_storage(2010)- target_ship.fuel) - fuel
              if(df < 0)
                df = -1 * df
              else
                df = 0
              end
              self.set_cargo(dm, dc, df)
              target_ship.user.add_resources(metal - dm, crystal - dc, fuel - df, target_ship)
            when 3
              target_ship = self.get_target_ship;

              self.ship_groups.each do |group|
                instance = target_ship.get_unit_instance(group.unit)
                instance.amount += group.number
                instance.save
              end
              self.clear_fleet
          end

          if(self.empty)
            self.destroy
            self.save
          else
            self.state = 2
            self.start_time = Time.now
            self.save
          end
        else
          home_ship = self.get_start_ship
          unit_instance = nil
          self.ship_groups.each do |group|
            unit_instance = home_ship.get_unit_instance(group.unit)
            unit_instance.amount = unit_instance.amount + group.number
            unit_instance.save
          end
          home_ship.user.add_resources(self.get_metal_cargo, self.get_crystal_cargo, self.get_fuel_cargo, home_ship)

          self.destroy
          self.save
        end
      end
    end
    return rest_time
  end
end
