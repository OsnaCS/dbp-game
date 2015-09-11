require 'TimeFormatter'

class UnitInstance < ActiveRecord::Base
  belongs_to :unit
  belongs_to :ship

  def update_time(format)
    unit = Unit.find_by(id: self.unit_id)
    durationInSeconds = format_count_time(unit.get_duration(1))
  end
end