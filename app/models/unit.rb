class Unit < ActiveRecord::Base
  belongs_to :damage_type
  belongs_to :message
  has_many :unit_instances, dependent: :destroy
  has_many :ships, :through => :unit_instances

  def get_duration(amount)
  	return self.duration * amount
  end

  def get_metal_cost
  	return self.metal_price * 500
  end

  def get_crystal_cost
  	return self.crystal_price * 500;
  end

  def get_fuel_cost
  	return self.fuel_price * 500;
  end
end