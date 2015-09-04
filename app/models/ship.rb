class Ship < ActiveRecord::Base

  has_many :ships_stations
  has_many :stations, :through => :ships_station
  after_create :create_stations

  private

  def create_stations
  $i=1
	
  while $i<3 do
    station=ShipsStation.new(ship_id: self.id, station_id: $i, level: "1").save
    $i=$i+1
  end

  while $i<17 do
    station=ShipsStation.new(ship_id: self.id, station_id: $i, level: "0").save
    $i=$i+1
  end
	
  end
end
