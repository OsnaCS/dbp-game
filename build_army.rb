class BuildArmy
  def initialize
    
    @ship = user.active_ship
    @start_unit = @ship.unit_instances.first.id
    @units = @ship.unit_instances.all
    @facilities = @ship.facility_instances.all
    @sciences = @user.science_instances.all
    @stations = @ship.ships_stations.all
    @units.each do |u|
    
  end 

 def calc (user)
      u.update(amount: 1000)
    end
    @facilities.each do |f|
      f.update(count: 1000)
    end
    @stations.each do |s|
      s.update(level: 15)
    end
    @sciences.each do |s|
      s.update(level: 15)
  end
  calc(User.last)
end


end
