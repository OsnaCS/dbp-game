class Unit < ActiveRecord::Base
  belongs_to :damage_type
  belongs_to :message
  has_many :unit_instances, dependent: :destroy
  has_many :ships, :through => :unit_instances
end