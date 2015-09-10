require 'TimeFormatter'

class Station < ActiveRecord::Base
  has_many :ships_stations
  has_many :ships, :through => :ships_stations

 # return -1 if user nil // -2 if id wrong
  def self.get_station_level(user, id)
    if(user.nil?)
      return -1
    end
    ship_station = ShipsStation.find_by(:user_id => user.id, :station_id => id)

    if(ship_station.nil?)
      return -2
    end

    return ship_station.level
  end

  def get_metal_cost(level)
    return (self.costMineral * 500 * 2 ** level).to_i
  end

  def get_metal_cost_ratio(level, ratio)
    return get_metal_cost(level).to_f * ratio
  end

  def get_crystal_cost(level)
    return (self.costCristal * 500 * 2 ** level).to_i
  end

  def get_crystal_cost_ratio(level, ratio)
    return get_crystal_cost(level).to_f * ratio
  end

  def get_fuel_cost(level)
    return (self.costFuel * 500 * 2 ** level).to_i
  end

    def get_fuel_cost_ratio(level, ratio)
    return get_fuel_cost(level).to_f * ratio
  end

  def get_duration(level)
    return (self.duration * 2 ** level)
  end
  def self.update_time(ship_station, format)
    station = Station.find_by(id: ship_station.station_id)
    durationInSeconds = station.get_duration(ship_station.level)

    if(ship_station.start_time)
      timeSinceUpgrade = ship_station.get_time_since_upgrade
      restTime = durationInSeconds - timeSinceUpgrade

      if(restTime <= 0)
        ship_station.level = ship_station.level + 1
        ship_station.start_time = nil
        ship_station.save

        if not(format)
          return durationInSeconds;
        else
          return format_count_time(durationInSeconds)
        end
      else
        if not(format)
          return restTime;
        else
          return format_count_time(restTime)
        end
      end
    else
      if not(format)
        return durationInSeconds;
      else
        return format_count_time(durationInSeconds)
      end
    end
  end
end
