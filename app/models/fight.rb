class Fight < ActiveRecord::Base
  belongs_to :attacker, classname => 'User'
  belongs_to :defender, classname => 'User'
end
