class FightingFleet < ActiveRecord::Base
  belongs_to :user
  belongs_to :fight, dependent: :destroy
  has_many :ship_groups, dependent: :destroy

  validates :id, uniqueness: true
 
#  validates :number, :numericality => { :greater_than_or_equal_to =>0 }
  accepts_nested_attributes_for :fight
  accepts_nested_attributes_for :ship_groups

  after_initialize :initialize_units, if: :new_record?
#  before_create :create_units

  def initialize_units    
    if self.fight.nil? 
      self.build_fight  
    end
    if self.ship_groups.empty?
      Unit.all.each do|u| 
        self.ship_groups.build  unit: u, number: 0
      end
    end
  end

  def create_units
  end    
end
