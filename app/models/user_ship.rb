class UserShip < ActiveRecord::Base
	belongs_to :ship
	belongs_to :user

	def name
		return ship.name
	end
end