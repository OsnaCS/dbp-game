module ShipGroupsHelper

  def ship_name
    return (Unit.find(self.ship_id)).name
  end
end
