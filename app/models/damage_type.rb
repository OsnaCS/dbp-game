class DamageType < ActiveRecord::Base 
  has_one :unit
  has_one :facility
end
