class Station < ActiveRecord::Base
  has_many :ships_stations
  has_many :ships, :through => :ships_stations
end
