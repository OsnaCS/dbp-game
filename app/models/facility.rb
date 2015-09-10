require 'TimeFormatter'

class Facility < ActiveRecord::Base
  has_many :facility_instances, dependent: :destroy
  has_many :ships, :through => :facility_instances
  validates_presence_of :cost1, :cost2, :cost3, :duration, :name, :facility_condition_id, :icon

  def is_hidden

    return true
  end

  # return -1 if user nil // -2 if id wrong
  def self.get_facility_count(user, id)
    if(user.nil?)
      return -1
    end
    instance = FacilityInstance.find_by(:user_id => user.id, :facility_id => id)

    if(instance.nil?)
      return -2
    end

    return instance.count
  end

  def self.update_time(instance, format)
    facility = Facility.find_by(id: instance.facility_id)
    durationInSeconds = facility.duration * (instance.create_count || 1) / (1 + 0.1 * ShipsStation.find_by(:ship_id => instance.ship_id, :station_id => 2006).level)

    if(instance.start_time)
      timeSinceResearch = (Time.now - instance.updated_at).to_i
      restTime = durationInSeconds - timeSinceResearch

      if(restTime <= 0)
        instance.count = instance.count + (instance.create_count || 1)
        instance.create_count = nil
        instance.start_time = nil
        instance.save

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
