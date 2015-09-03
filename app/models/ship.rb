class Ship < ActiveRecord::Base
	has_many :ships_stations
	has_many :stationtypes, :through => :ships_station
	around_create :create_stations

	private
	def create_stations

	end
end 
