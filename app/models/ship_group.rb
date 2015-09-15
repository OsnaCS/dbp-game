class ShipGroup < ActiveRecord::Base
  belongs_to :fighting_fleet
  belongs_to :unit
  validates :number, :numericality => { :greater_than_or_equal_to => 0 }

  def ship_name
    return Unit.find()
  end

  def get_damage
    return self.unit.damage.to_i    
  end
  def get_damage_type
    return self.unit.damage_type_id.to_i    
  end
  
  def get_number
    return self.number.to_i
  end
 
  def get_hp
    return self.unit.shell.to_i
  end
  def get_id
    return self.unit.id.to_i
  end 

  def get_name
    return self.unit.name
  end

  def get_cargo
    return self.unit.cargo
  end
end
