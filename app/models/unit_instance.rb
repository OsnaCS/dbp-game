class UnitInstance < ActiveRecord::Base
  belongs_to :unit
  belongs_to :ship
end