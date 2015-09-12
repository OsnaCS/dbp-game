class ExpeditionInstance < ActiveRecord::Base
	belongs_to :expedition
    belongs_to :user
end
