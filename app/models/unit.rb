class Unit < ActiveRecord::Base
  belongs_to :damage_type
  belongs_to :message
  belongs_to :science_one, :class_name => 'Science', :foreign_key => 'science_one_id'
  belongs_to :science_two, :class_name => 'Science', :foreign_key => 'science_two_id'
end
