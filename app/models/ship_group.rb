class ShipGroup < ActiveRecord::Base
  belongs_to :fighting_fleet
  belongs_to :ship
end
