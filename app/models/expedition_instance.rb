class ExpeditionInstance < ActiveRecord::Base
	belongs_to :expidition
    belongs_to :user
end
