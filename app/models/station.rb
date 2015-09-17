require 'TimeFormatter'

class Station < ActiveRecord::Base
  has_many :ships_stations
  has_many :ships, :through => :ships_stations
  validates_presence_of :name

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

  def self.update_time(instance, format)
    station = instance.station
    durationInSeconds = instance.get_duration(instance.level)

    if(instance.start_time != nil)
      timeSinceUpgrade = (Time.now - instance.start_time).to_i
      restTime = durationInSeconds - timeSinceUpgrade

      if(restTime <= 0)
        instance.level = instance.level + 1
        instance.save
        instance.reset_build

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
