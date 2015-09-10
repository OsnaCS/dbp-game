class Fight< ActiveRecord::Base
  belongs_to :user
  belongs_to :attacker, :class_name => 'User', :foreign_key => 'attacker_id', inverse_of: :attacks
  belongs_to :defender, :class_name => 'User', :foreign_key => 'defender_id', inverse_of: :defends
  has_one :fighting_fleet 

  
  # Methode to start the report-creating with the names of the attacker 
  # and defender
  def report_start
   @report= "Kampfbericht: \n \n Angreifer: #{self.attacker.username} Verteidiger: #{self.defender.username} \n \n "
  end

  def user_science_level(user, science_id)
    if (user.is_user)
      self.user.science_instances.find_by(science_id: science_id).level
    end
  end

  def pilottraining_id
    return 4007
  end
  def spy_id
    return 4003
  end

  def emp_ship_id
    return 11
  end

  def spy_ship_id
    return 4
  end
  # Methode to calculate the threshold of for succesfull spying
  def threshold_spy
    return (user_science_level(defender, spy_id) - user_science_level(attacker, spy_id))*0.05+0.5  
  end

  def number_of_ships(user, unit_id)
    if(user==self.attacker)
      return self.fighting_fleet.ship_groups.find_by(unit_id: unit_id).number
    elseif (user ==self.defender)
      #MUSS NOCH ANGEPASST WERDEN!!!!!!!!!EINSELF
      return 0 
    end

  end

  # Calculate the threshold for a succesfull emp-event
  def threshold_emp(user)
      return (1-(1/(1+0.5*number_ships_ships(user,emp_ship_id))))
  end

  # Random float from 0 to 1
  def random_to_one
    return rand()
  end 
  
  def get_x_for_random(user)

    return (1.3 -(0.01 * user_science_level(user, pilottraining_id)))
    
  end

  # Random float from 0 to x
  def random_to_x(user)
    return rand(get_x_for_random(user))
  end

  # Methode for the spying-event
  def spy_phase
    if number_of_ships(self.attacker, spy_ship_id) > 0
      # SPY_EVENT wird gestartet
      if threshold_spy > tmp_random
        #Spyprobes leave battle!!
        spy_report(true, true)
        #STARTE EVENT
      else 
        #Spionage gescheitert
        spy_report(true, false)
    end
        #Spionage nicht gestartet
        spy_report(false, false)
    end
  end
  
  # Adds the result of the spying to the report
  def spy_report(spy_start, spy_success)
    if spy_start
      @report << "  Spionagebericht:  \n \n "
      if spy_success
        @report << "Spionage erfolgreich! \n \n"
        #START EVENT!!!!
      else
        @report << "Spionage fehlgeschlagen! Ihre Spionagedrohnen wurden zerstört"
      end
      @report << "Keine Drohnen verschickt!"
    end
  end
  def spy_event
    spy_level= user_science_level(self.attacker, spy_id)
    if spy_level>=2
      #EVENT Gesamtzahl Ressourcen, Einheiten und Anlagen
      if spy_level >=8
        #EVENT Seperate Auflistung
        if spy_level >=16
          #EVENT Seperate Forschung
        end
      end
      else
      #Spionagelevel zu niedrig.
    end
  end
 
 # Trying to destroy shields
  def emp_phase(user)
    emp_ships=number_of_ships(user, emp_ship_id)
    if emp_ships > 0
      if threshold_emp > random_to_one
        #Report + Schilde
      else
        #Report
      end
      #Report
    end
    
  end

  # Adds the result from the emp-event to the report
  def emp_report (emp_start, emp_success)
    
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
