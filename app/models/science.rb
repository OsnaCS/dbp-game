require 'TimeFormatter'

class Science < ActiveRecord::Base
  has_one :science_one, :class_name => 'Unit', :foreign_key => "science_one_id"
  has_one :science_two, :class_name => 'Unit', :foreign_key => "science_two_id"
  has_many :science_instances, dependent: :destroy
  has_many :users, :through => :science_instances
  validates_presence_of :cost1, :cost2, :cost3, :factor, :duration, :name, :tier, :science_condition_id, :icon

  def has_level_cap
    return self.level_cap > -1
  end

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

  def get_duration(level, ship)
    research_station_level = ShipsStation.find_by(:ship_id => ship.id, :station_id => 2004).level
    return (self.duration * self.factor ** (level + 1)) / (1 + 0.1 * research_station_level)
  end
end