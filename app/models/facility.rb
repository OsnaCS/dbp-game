require 'TimeFormatter'

class Facility < ActiveRecord::Base
  has_many :facility_instances, dependent: :destroy
  has_many :ships, :through => :facility_instances
  validates_presence_of :cost1, :cost2, :cost3, :duration, :name, :facility_condition_id, :icon
  belongs_to :damage_type

  def get_total_cost
    return self.get_fuel_cost * 4 + self.get_crystal_cost * 2 + self.get_metal_cost
  end

    def get_metal_cost
    return self.cost1 * 500
  end

  def get_crystal_cost
    return self.cost2 * 500
  end

  def get_fuel_cost
    return self.cost3 * 500
  end

  def get_metal_cost_ratio(ratio)
    return self.get_metal_cost * ratio
  end

  def get_crystal_cost_ratio(ratio)
    return self.get_crystal_cost * ratio
  end

  def get_fuel_cost_ratio(ratio)
    return self.get_fuel_cost * ratio
  end

  def self.update_time(instance, format)
    durationInSeconds = instance.get_duration()
    if(instance.start_time != nil)
      timeSinceResearch = (Time.now - instance.start_time).to_i
      restTime = durationInSeconds - timeSinceResearch

      if(restTime <= 0)
        instance.create_count -= 1 
        instance.count += 1
        instance.start_time = Time.now
        instance.save
        if(instance.create_count <= 0)
          instance.reset_build
        end

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
