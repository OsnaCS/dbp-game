require 'TimeFormatter'

class Science < ActiveRecord::Base
  has_one :science_one, :class_name => 'Unit', :foreign_key => "science_one_id"
  has_one :science_two, :class_name => 'Unit', :foreign_key => "science_two_id"
  has_many :science_instances, dependent: :destroy
  has_many :users, :through => :science_instances
  validates_presence_of :cost1, :cost2, :cost3, :factor, :duration, :name, :tier, :science_condition_id, :icon

  # return -1 if user nil // -2 if id wrong
  def self.get_science_level(user, id)
    if(user.nil?)
      return -1
    end
    instance = ScienceInstance.find_by(:user_id => user.id, :science_id => id)

    if(instance.nil?)
      return -2
    end

    return instance.level
  end

  def self.update_time(instance, format)
    science = Science.find_by(id: instance.science_id)
    durationInSeconds = science.duration * science.factor ** (instance.level + 1)

    if(instance.start_time)
      timeSinceResearch = (Time.now - instance.updated_at).to_i
      restTime = durationInSeconds - timeSinceResearch

      if(restTime <= 0)
        instance.level = instance.level + 1
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
