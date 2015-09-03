class FightingFleet < ActiveRecord::Base
  belongs_to :user
  has_many :ship_groups
end
