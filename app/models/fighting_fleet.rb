class FightingFleet < ActiveRecord::Base
  belongs_to :user
  belongs_to :fight
  has_many :ship_groups
  accepts_nested_attributes_for :fight
  accepts_nested_attributes_for :ship_groups

  after_initialize :create_units, if: :new_record?

  def create_units
    
    Unit.all.each do|u| 
      self.ship_groups.build number: 0, unit_id: u.id
      end
    end
  end
