class Fight< ActiveRecord::Base
  belongs_to :user
  belongs_to :attacker, :class_name => 'User', :foreign_key => 'attacker_id', inverse_of: :attacks
  belongs_to :defender, :class_name => 'User', :foreign_key => 'defender_id', inverse_of: :defends
  has_one :fighting_fleet 

#  def initialize
#     @number_of_spy_probes = 1
#     @number_of_emp_ships = 4
#     @spy_level_attacker = 2
#     @spy_level_defender = 1
#     @spy_event = true
     
#     @ships = {s1: {name: "ship1", damage: 5, hp: 15, number: 4}, s2: {name: "ship2", damage: 4, hp: 20, number: 5}}
#  end

  def time_to_fight
#    time=self.time.to_i - Time.now.to_i 
    return 2 
  end
  
  # Methode to start the report-creating with the names of the attacker 
  # and defender
  def report_start
   return "Kampfbericht: \n \n Angreifer: #{self.attacker.username} Verteidiger: #{self.defender.username} \n \n "
  end

  # Methode to calculate the threshold of for succesfull spying
  def threshold_spy
    puts "Ergebnis:"
    puts (@spy_level_defender - @spy_level_attacker)*0.05+0.5  
    return (@spy_level_defender - @spy_level_attacker)*0.05+0.5  
  end

  # Calculate the threshold for a succesfull emp-event
  def threshold_emp
      return (1-(1/(1+0.5*@number_of_emp_ships)))
  end

  # Random float from 0 to 1
  def random_to_one
    return rand()
  end 
  
  # Random float from 0 to x
  def random_to_x(max)
    return rand(max)
  end
  # Methode for the spying-event
#  def spy_phase
#    puts("Anzahl der Spionage Drohnen:" + @number_of_spy_probes.to_s)
#    if @number_of_spy_probes.to_f > 0
#      puts tmp_random=random_to_one
#      if threshold_spy > tmp_random
#        #Spyprobes leave battle!!
#        puts "Spionage geglückt!"
#        return @spy_event=true
#     
#    end
#      puts "Spionage gescheitert!"
#      return @spy_event=false
#    end
#  end
  
  # Adds the result of the spying to the report
  def spy_report
    tmp="  Spionagebericht:  \n \n "
    if (@spy_event)
      tmp2= " #{tmp} Erfolg! Die Spionage ergab folgende Einblicke: \n \n"
    else
      tmp2= " #{tmp} Misserfolg! Ihre Dronen wurden zerstört. \n \n"
    end
  end
  
  # Trying to destroy shields
 # def emp_phase
 #   if @number_of_emp_ships > 0
 #     tmp = threshold_emp
 #     randomtmp = random_to_one
 #     if tmp > randomtmp
 #       puts "Schilde zerstört!!! #{tmp} #{randomtmp}"
 #       return true
 #     end
 #   end
 #   puts "Schilde nicht zerstört!!! #{tmp} #{randomtmp} "
 #   return false
    
  end

  # Adds the result from the emp-event to the report
  def emp_report
    
  end


  def fight
    attackers_turn =true
    ship_ary =[]
    ships.each do |key|
      print key
        key.each do |name, damage, hp, number|
        puts " #{name} #{damage} #{hp} #{number}"
      
        end    
      end
    end

  # Hilfsmethode zum testen, WIEDER LÖSCHEN!!!
  def ships
    return @ships
  end
 


#f=Fight.new
#f.@number_of_spy_probes =1
#puts "Starte Spy Phase:"
#f.number_of_spy_probes = 1
#f.emp_phase
#f.spy_phase
#f.fight
#end
