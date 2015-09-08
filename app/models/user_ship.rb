class UserShip < ActiveRecord::Base
	belongs_to :ship
	belongs_to :user
end
