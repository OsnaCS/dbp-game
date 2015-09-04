class Science < ActiveRecord::Base
  has_many :science_instances
  has_many :users, :through => :science_instances

end
