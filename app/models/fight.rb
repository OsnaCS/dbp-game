class Fight#< ActiveRecord::Base
#  belongs_to :user
#  belongs_to :attacker, :class_name => 'User', :foreign_key => 'attacker_id', inverse_of: :attacks
#  belongs_to :defender, :class_name => 'User', :foreign_key => 'defender_id', inverse_of: :defends
 

  def initialize
     @number_of_spy_probes = 1
     @number_of_emp_ships = 4
     @spy_level_attacker = 2
     @spy_level_defender = 1
     @spy_event = true
     @ships = {s1: {name: "ship1", damage: 5, hp: 15}, s2: {name: "ship2", damage: 4, hp: 20}}
 
  end

  def time_to_fight
#    time=self.time.to_i - Time.now.to_i 
    return 2 
  end

  def report_start
   return "Kampfbericht: \n \n Angreifer: #{self.attacker.username} Verteidiger: #{self.defender.username} \n \n "
  end

  def threshold
    puts "Ergebnis:"
    puts (@spy_level_defender - @spy_level_attacker)*0.05+0.5  
    return (@spy_level_defender - @spy_level_attacker)*0.05+0.5  
  end

  def random
    return rand()
  end 


  def spy_phase
    puts("Anzahl der Spionage Drohnen:" + @number_of_spy_probes.to_s)
    if @number_of_spy_probes.to_f > 0
      puts tmp=random
      if threshold > tmp
        #Spyprobes leave battle!!
        puts "Spionage geglückt!"
        return @spy_event=true
     
    end
      puts "Spionage gescheitert!"
      return @spy_event=false
    end
  end
  
  def spy_report
    tmp="  Spionagebericht:  \n \n "
    if (@spy_event)
      tmp2= " #{tmp} Erfolg! Die Spionage ergab folgende Einblicke: \n \n"
    else
      tmp2= " #{tmp} Misserfolg! Ihre Dronen wurden zerstört. \n \n"
    end
  end

  def emp_phase
    if @number_of_emp_ships > 0
      tmp = (1-(1/(1+0.5*@number_of_emp_ships)))
      randomtmp = random
      if tmp > randomtmp
        puts "Schilde zerstört!!! #{tmp} #{randomtmp}"
        return true
      end
    end
    puts "Schilde nicht zerstört!!! #{tmp} #{randomtmp} "
    return false
    
  end


 


f=Fight.new
#f.@number_of_spy_probes =1
#puts "Starte Spy Phase:"
#f.number_of_spy_probes = 1
f.emp_phase
f.spy_phase


end
