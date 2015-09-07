require 'TimeFormatter'

class Science < ActiveRecord::Base
  has_many :science_instances, dependent: :destroy
  has_many :users, :through => :science_instances
  validates_presence_of :cost1, :cost2, :cost3, :factor, :duration, :name, :tier, :science_condition_id, :icon

  def self.get_sciences(user)
    scienceHash = Hash.new(0)
    user.science_instances.each do |s|
      scienceHash[s.science] = s.level
    end

    instance = nil
    Science.all.each do |s|
      if not(scienceHash.has_key? s)
        instance = ScienceInstance.new
        instance.science_id = s.id
        instance.user_id = user.id
        instance.level = 0
        ScienceInstance.create(:science_id => s.id, :user_id => user.id, :level => 0)
        scienceHash[s] = instance.level
      end
    end
    return scienceHash
  end

  def self.update_time(instance)
    science = Science.find_by(id: instance.science_id)
    durationInSeconds = science.duration * science.factor * (instance.level + 1)

    if(instance.start_time)
      timeSinceResearch = (Time.now - instance.updated_at).to_i
      restTime = durationInSeconds - timeSinceResearch

      if(restTime <= 0)
        instance.level = instance.level + 1
        instance.start_time = nil
        instance.save
        return format_count_time(durationInSeconds)
      else
        return format_count_time(restTime)
      end
    else
      return format_count_time(durationInSeconds)
    end
  end
end
