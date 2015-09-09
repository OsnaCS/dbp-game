class FightingFleet < ActiveRecord::Base
  belongs_to :user
  belongs_to :fight
  has_many :ship_groups, dependent: :destroy
  accepts_nested_attributes_for :fight
  accepts_nested_attributes_for :ship_groups

  after_initialize :initialize_units, if: :new_record?
#  before_create :create_units

  def initialize_units
    
    Unit.all.each do|u| 
      self.ship_groups.build number: 0, unit: u, group_hitpoints: 0
      end
    end

  def create_units
  end    
end
