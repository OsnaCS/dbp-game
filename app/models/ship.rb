class Ship < ActiveRecord::Base
	has_many :ships_stations
	has_many :stationtypes, through => :ships_station
	
end 
