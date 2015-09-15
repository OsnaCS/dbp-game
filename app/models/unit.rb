class Unit < ActiveRecord::Base
  belongs_to :damage_type
  belongs_to :message
  has_many :unit_instances, dependent: :destroy
  has_many :ships, :through => :unit_instances
  validates_presence_of :metal_price, :crystal_price, :fuel_price, :name, :condition_id, :icon, :shell, :damage, :damage_type_id, :cargo, :speed

  def get_total_cost
    return self.get_fuel_cost * 4 + self.get_crystal_cost * 2 + self.get_metal_cost
  end

  def get_metal_cost
  	return self.metal_price * 500
  end

  def get_crystal_cost
  	return self.crystal_price * 500
  end

  def get_fuel_cost
  	return self.fuel_price * 500
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
        instance.build_amount -= 1 
        instance.amount += 1
        instance.start_time = Time.now
        instance.save
        if(instance.build_amount <= 0)
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