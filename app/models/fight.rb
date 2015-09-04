class Fight < ActiveRecord::Base
#  belongs_to :user
  belongs_to :attacker, :class_name => 'User', :foreign_key => 'attacker_id', inverse_of: :attacks
  belongs_to :defender, :class_name => 'User', :foreign_key => 'defender_id', inverse_of: :defends

  def time_to_fight
    
  end

  def report_start
   return "Kampfbericht: \n \n Angreifer: #{self.attacker.username} Verteidiger: #{self.defender.username} \n \n "
  end
end
