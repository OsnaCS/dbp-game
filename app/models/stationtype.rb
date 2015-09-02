class Stationtype < ActiveRecord::Base
	has_and_belongs_to_many :ships
end
