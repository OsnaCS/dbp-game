class ShipGroup < ActiveRecord::Base
  belongs_to :fighting_fleet
  belongs_to :unit


  def ship_name
    return Unit.find()
  end
end
