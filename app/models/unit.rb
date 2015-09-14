class Unit < ActiveRecord::Base
  belongs_to :damage_type
  belongs_to :message
  belongs_to :science_one, :class_name => 'Science', :foreign_key => 'science_one_id'
  belongs_to :science_two, :class_name => 'Science', :foreign_key => 'science_two_id'
  has_many :unit_instances, dependent: :destroy
  has_many :ships, :through => :unit_instances

  def get_max_units_to_buy(user)
    amounts = []

    if(get_metal_cost!=0)
      amounts << user.get_metal/get_metal_cost
    end
    if(get_crystal_cost!=0)
      amounts << user.get_crystal/get_crystal_cost
    end
    if(get_fuel_cost!=0)
      amounts << user.get_fuel/get_fuel_cost
    end
    
    return amounts.min
  end
  
  def get_total_cost
    return self.get_fuel_cost * 4 + self.get_crystal_cost * 2 + self.get_metal_cost
  end

  def get_duration(amount, ship)
    factor = (1 + 0.1 * ShipsStation.find_by(:ship_id => ship.id, :station_id => 2006).level) 
    return ((self.get_total_cost / 500) * 2 * amount) / factor
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

  def get_metal_cost_ratio(ratio)
    return self.get_metal_cost * ratio
  end

  def get_crystal_cost_ratio(ratio)
    return self.get_crystal_cost * ratio
  end

  def get_fuel_cost_ratio(ratio)
    return self.get_fuel_cost * ratio
  end
end
