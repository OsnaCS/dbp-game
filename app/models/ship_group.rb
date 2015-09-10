class ShipGroup < ActiveRecord::Base
  belongs_to :fighting_fleet
  belongs_to :unit
  validates :number, :numericality => { :greater_than_or_equal_to => 0 }

  def ship_name
    return Unit.find()
  end
end
