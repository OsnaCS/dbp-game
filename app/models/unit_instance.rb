require 'TimeFormatter'

class UnitInstance < ActiveRecord::Base
  belongs_to :unit
  belongs_to :ship

  def get_time_since_build
    return (Time.now - self.updated_at).to_i
  end

  def update_time(format)
    unit = Unit.find_by(id: self.unit_id)
    durationInSeconds = unit.get_duration(1)

    if(self.start_time)
      buildAmount =  self.build_amount
      durationInSeconds = unit.get_duration(buildAmount)
      timeSinceBuild = self.get_time_since_build
      restTime = durationInSeconds - timeSinceBuild

      if(restTime <= 0)
        self.amount = self.amount + buildAmount
        self.start_time = nil
        self.build_amount = nil
        self.save

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