class FightingFleet < ActiveRecord::Base
  belongs_to :user
  belongs_to :expidition
  has_many :ship_groups
end
