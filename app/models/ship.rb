class Ship < ActiveRecord::Base

  has_many :ships_stations
  has_many :stations, :through => :ships_stations
  after_initialize :create_stations, if: :new_record?

  private

  def create_stations
    Station.all.each do |station|
      self.ships_stations.build(ship: self, station: station, level: station.initial_level)
    end
    save
  end
end
