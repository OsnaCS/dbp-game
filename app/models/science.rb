require 'TimeFormatter'

class Science < ActiveRecord::Base
  has_many :science_instances, dependent: :destroy
  has_many :users, :through => :science_instances
  validates_presence_of :cost1, :cost2, :cost3, :factor, :duration, :name, :tier, :science_condition_id, :icon

  def get_metal_cost(level)
    return (self.cost1 * 500 * self.factor ** (level)).to_i
  end

  def get_metal_cost_ratio(level, ratio)
    return get_metal_cost(level).to_f * ratio
  end

  def get_crystal_cost(level)
    return (self.cost2 * 500 * self.factor ** (level)).to_i
  end

  def get_crystal_cost_ratio(level, ratio)
    return get_crystal_cost(level).to_f * ratio
  end

  def get_fuel_cost(level)
    return (self.cost3 * 500 * self.factor ** (level)).to_i
  end

  def get_fuel_cost_ratio(level, ratio)
    return get_fuel_cost(level).to_f * ratio
  end

  def self.update_time(instance, format)
    science = instance.science
    durationInSeconds = instance.get_duration(instance.level)

    if(instance.start_time != nil)
      timeSinceResearch = (Time.now - instance.start_time).to_i
      restTime = durationInSeconds - timeSinceResearch

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