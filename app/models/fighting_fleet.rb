class FightingFleet < ActiveRecord::Base
  @@missions = {1 => "Angriff", 2 => "Transport", 3 => "Stationieren"}
  @@state = {1 => "Hinflug", 2 => "Rückflug"}

  belongs_to :user
  belongs_to :expedition
  belongs_to :fight, dependent: :destroy
  has_many :ship_groups, dependent: :destroy

  validates :id, uniqueness: true
 
#  validates :number, :numericality => { :greater_than_or_equal_to =>0 }
  accepts_nested_attributes_for :fight
  accepts_nested_attributes_for :ship_groups

  after_initialize :initialize_units, if: :new_record?
#  before_create :create_units

  def initialize_units    
    if self.fight.nil? 
      self.build_fight  
    end
    if self.ship_groups.empty?
      Unit.all.each do|u| 
        self.ship_groups.build  unit: u, number: 0
      end
    end
  end

  def self.mission
    return @@missions
  end

  def empty
    return false
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
    return 1
  end

  def get_duration
    return 10
  end

  def get_data
    return self.data.split(",")
  end

  def get_target_ship
    return Ship.find_by(:id => self.get_data[1].to_i)
  end

  def clear_cargo
    data = self.get_data
    data[0] = "0:0:0"
    newData = ""

    first = true
    data.each do |d|
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

  def get_metal_cargo
    return self.get_data[0].split(":")[0].to_i
  end

  def get_fuel_cargo
    return self.get_data[0].split(":")[1].to_i
  end

  def get_crystal_cargo
    return self.get_data[0].split(":")[2].to_i
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
      one_way_duration = self.get_duration
      rest_time = one_way_duration - self.get_time_since_start

      if(rest_time <= 0)
        if(self.state == 1)
          case self.mission
            when 1
              ##Kampf
            when 2
              target_ship = self.get_target_ship
              target_ship.user.add_resources(self.get_metal_cargo, self.get_crystal_cargo, self.get_fuel_cargo, target_ship)
              self.clear_cargo

            when 3
              #Stationieren
          end

          if(self.empty)
            #Flotte nach dem Kampf zerstört
          else
            self.state = 2
            self.start_time = Time.now
            self.save
          end
        else
          self.destroy
          self.save
        end
      end
    end
    return rest_time
  end
end