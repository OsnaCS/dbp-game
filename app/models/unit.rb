class Unit < ActiveRecord::Base
  belongs_to :damage_type
  belongs_to :message
end
