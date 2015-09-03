class ShipGroup < ActiveRecord::Base
  belongs_to :fleet
  belongs_to :ship
end
