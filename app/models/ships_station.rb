class ShipsStation < ActiveRecord::Base

  belongs_to :ship
  belongs_to :station
end
