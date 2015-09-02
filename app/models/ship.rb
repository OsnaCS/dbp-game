class Ship < ActiveRecord::Base
	has_and_belongs_to_many :stationtypes
end
