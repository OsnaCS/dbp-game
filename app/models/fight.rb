class Fight< ActiveRecord::Base
  belongs_to :user
  belongs_to :attacker, :class_name => 'User', :foreign_key => 'attacker_id', inverse_of: :attacks
  belongs_to :defender, :class_name => 'User', :foreign_key => 'defender_id', inverse_of: :defends
  has_one :fighting_fleet 

  def init_vars
    @report = []
    @round_reports = []
    @spy_science_id = 4007
    @pilot_science_id = 4003
    @shell_science_id = 4001
    @laser_science_id = 4002
    @ionen_science_id = 4005
    @shield_science_id = 4006
    @bomb_science_id = 4010
    @emp_ship_id = 11
    @spy_ship_id = 4 
    @shield_ship_id = 12
    @all_groups_attacker
    @all_groups_defender
    @attacker = self.attacker
    @defender = self.defender
    @attacker_fleet = self.fighting_fleet
    @defender_fleet = FightingFleet.first
    #Zu Testzwecken
    @attacker_level = build_level(@attacker)
    @defender_level = build_level(@defender)
    #@defender_fleet=defender.ship.find_by(@attacked_ship)
    @attacker_shield = shield_cal( @attacker)
    @defender_shield = shield_cal( @defender)
    @fight_shield = 0
  end

  # Lädt den Titel mit Agreifer und Verteidiger in den Kampfbericht 
  def report_start
   @report << "Kampfbericht:" 
   @report << " Angreifer: #{self.attacker.username} Verteidiger: #{self.defender.username} "
  end
  
  def user_science_level(user, id)
    return user.science_instances.find_by(science_id: id).level
  end

  # Berechnet die Schwelle für eine geglückte Spionage
  def threshold_spy
    return (@defender_level[6] - @attacker_level[6]) * 0.05 + 0.5  
  end
 
  # Berechnet die Anzahl der Schiffe mit der unit_id vom Spieler user
  def amount_of_ships(user, unit_id)
    if(user == @attacker)
      tmp = @attacker_fleet.ship_groups.find_by(unit_id: unit_id).number
      return tmp.to_i
    elsif (user ==@defender)
      #MUSS NOCH ANGEPASST WERDEN!!!!!!!!!EINSELF
      return @defender_fleet.ship_groups.find_by(unit_id: unit_id).number
    end

  end

  # Berechnet die Schwelle für einen geglückten EMP-Angriff
  def threshold_emp(user)
      return (1- ( 1 / (1 + 0.5 * amount_of_ships(user, @emp_ship_id))))
  end

  # Zufalls Zahl zwischen 1 und 0
  def random_to_one
    return rand()
  end 
  
  # Berechnet die maximale Zufallszahl für user (Treffer und welches Ziel)
  def get_x_for_random(user1)
    array = @defender_level
    if user == @attacker
      array = @attacker_level
    end
    tmp= (1.3 -(0.01 * array[5]))
    if tmp < 1
    tmp = 1
    end
    return 1
  end

  # Zufallszahl zwischen 0 und x
  def random_to_x(user)
    return rand(get_x_for_random(user))
  end

  # Testet ob Spionage geklappt hat und leitet Bericht ein
  # MUSS NOCH ERWEITERT WERDEN!!!!!!!
  def spy_phase
    if amount_of_ships(self.attacker, @spy_ship_id) > 0
      # SPY_EVENT wird gestartet
      if threshold_spy > random_to_one
        #Spyprobes leave battle!!
        spy_report(true, true)
        #STARTE EVENT
      else 
        #Spionage gescheitert
        spy_report(true, false)
      end
    else    #Spionage nicht gestartet
        spy_report(false, false)
    end
  end
  
  # Für die Ausgabe des Berichtes
  def spy_report(spy_start, spy_success)
    if spy_start
      @report << "  Spionagebericht: "
      if spy_success
        @report << "Spionage erfolgreich! #{@defender.username} wurde ausspioniert."
        spy_event
      else
        @report << "Spionage fehlgeschlagen! Spionagedrohnen von #{@attacker.username} wurden zerstört"
      end
    end
  end

  # Welchen Bericht erhält angreifer, falls geglückte Spionage
  # MUSS NOCH ERWEITERT WERDEN!!!!!!!!
  def spy_event
    spy_level = user_science_level(@attacker, @spy_science_id)
    if spy_level >= 2
      #EVENT Gesamtzahl Ressourcen, Einheiten und Anlagen
      if spy_level >= 8
        #EVENT Seperate Auflistung
        if spy_level >= 16
          #EVENT Seperate Forschung
        end
      end
      else
      #Spionagelevel zu niedrig.
    end
  end
 
  # Testet, ob emp_phase von user klappt
  def emp_phase(user)
    if amount_of_ships(user, @emp_ship_id) > 0
      if threshold_emp(user) > random_to_one
        emp_report(user, true, true)
        if user==@attacker
          @defender_shield = 0
        else
          @attacker_shield = 0
        end
      else
        emp_report(user, true, false)
      end
    else 
      emp_report(user, false, false)
    end
  end

  # Bericht bei geglücktem EMP
  def emp_report (user, emp_start, emp_success)
    activ = @defender
    passiv = @attacker
    if(user == @attacker)
      activ = @attacker
      passiv = @defender
    end
    if emp_start
        @report << "  Emp-Phase von #{activ.username}:  "
      if emp_success
        @report << "Der EMP war erfolgreich!! Schild von #{passiv.username} wurde deaktiviert "
      else
        @report << "Der EMP war nicht erfolgreich. Schild von #{passiv.username} wurden nicht zerstört."
      end
    else 
    end  
  end
  
  # Testet, ob eine Flotte noch Schiffe hat
  def defeat(fleet)
    count_all_ships = 0
    fleet.each do |a|
      count_all_ships = count_all_ships + a[2]
    end
    return count_all_ships == 0
  end


  # Baut ein Array mit allen Schiffsgruppen des Spielers user aus der
  # Flotte fleet
  def build_array ( user, fleet )
    if ( user == @attacker )
      array = @attacker_level
    else
      array = @defender_level
    end
    fleet_array = []
    fleet.ship_groups.each do |sg|
      amount = sg.get_number
      if (amount > 0)
        id = sg.get_id
        damage_sum = sg.get_damage * amount
        damage_type = sg.get_damage_type
        hp_sum = sg.get_hp * amount * (1 + (0.1 * array[0])).to_i
        hitchance = 0.0
        damage_sum = damage_sum*(1 + (0.1 * mult_weapon_level(damage_type, user)))
        lost_ships = 0
        name = sg.get_name 
        fleet_array << [id, amount, damage_sum, damage_type, lost_ships, name, hp_sum, hitchance]
      end
    end
    return get_hitchances(sort_by_damage(fleet_array))
  end
 
  # Fragt das Waffenlevel der jeweiligen Waffe ab von Spieler user
  def mult_weapon_level (damagetype, user)
    if user == @attacker
      array = @attacker_level
    else
      array = @defender_level
    end
    mult = 0
    case damagetype
      when 1
        mult = array[2]
      when 2
        mult = array[3]
      when 3
        mult = array[4]
    end
    return mult
  end

   
  # Sortiert das fleet_array nach Stärken der einzelnden Schiffsgruppen 
  def sort_by_damage(fleet_array)
    fleet_array.sort {|a,b| b[2]<=>a[2]}
  end
  
  # Berechnet die Wahrscheinlichkeit aller Schiffsgruppen, 
  # getroffen zu werden
  def get_hitchances(fleet_array)
    total_tp = 0
    fleet_array.each do |a|
      total_tp = total_tp + a[-2]
    end
    fleet_array.each do |a|
      a[-1] = (a[-2].to_f/total_tp.to_f)
    end
  end
  
  # Berechnet, welche Schiffsgruppe getroffen wurde
  # -1 ist Schild
  # -2 ist Miss
  def hit(enemy_fleet_array, user)
      if (@fight_shield < 0)
      index = 0
      hit_index = random_to_x(user)
      if (hit_index <= 1)
        enemy_fleet_array.each do |sg|
          hit_index = hit_index - sg[-1]
          if (hit_index < 0)
            return index
          end
          index = index + 1
        end    
      end
      return -2
    end
    return -1
  end
 
  # Bringt die Daten der Schiffsgruppe nach Angriff auf neusten Stand
  def update_ship_group(group)
    if group[-2] < 0
      group[-2] = 0
    end
    hp_one = Unit.find(group[0]).shell
    damage_one = Unit.find(group[0]).damage
    group[1] = (group[-2] / hp_one).ceil
    group[2] = group[1] * damage_one
  end   

  # Berechnet das Schild von user
  # MUSS NOCH ANGEPASST WERDEN!!!!!!!!!!!!!!!!
  def shield_cal(user)
    amount = amount_of_ships(user, @shield_ship_id)
    level_shield=user_science_level(user, @shield_science_id) 
    if (user == @defender)
      #add shield
    end
    return amount * 5
  end
  
  def build_level(user)
    shell=user_science_level(user, @shell_science_id)
    shield=user_science_level(user, @shield_science_id)
    laser=user_science_level(user, @laser_science_id)
    ionen=user_science_level(user, @ionen_science_id)
    bomb=user_science_level(user, @bomb_science_id)
    pilot=user_science_level(user, @pilot_science_id)
    spy=user_science_level(user, @spy_science_id)
    return [shell, shield, laser, ionen, bomb, pilot, spy]
  end
  
  def battle
    round = 0
    continue = true
    turn_fleet = build_array(@attacker, @attacker_fleet)
    target_fleet = build_array(@defender, @defender_fleet)
    turn_user = @atacker
    target_user = @defender
    while (round < 10 && continue) do
      if target_user == @defender
        @fight_shield = @defender_shield
      else
        @fight_shield = @attacker_shield
      end
      shield = @fight_shield
      round_report = []
      round_report << "Runde #{round}: "
      round_report << "#{turn_user} ist am Zug."
      if shield > 0
        round_report << "Schild von #{target_user.username} ist aktiv."
        round_report << "Schild hält noch #{shield} Schaden aus."
        round_report << "Alle Truppen schießen auf den Schildt!"
      else  
        round_report << "Schild von #{target_user.username} ist inaktiv."
        round_report << "Angriffe werden nicht abgewehrt!"
        round_report << " "
      end
      turn_fleet.each do |a|
        round_report << "#{a[5]} trifft... "
        target = hit(target_fleet, turn_user)
        #Falls Ionenwaffe
        if(shield > 0)
          if(target==-2)
          end
          mult = 1
          if a[3] == 2
            mult = 1.5
          end
          damage = a[2] * mult
          @fight_shield = @fight_shield - damage
        else  
        
          mult=1
          if(a[3]==1)
            mult=1.5
          end 
          victim=target_fleet[target]
          damage=a[2]*mult
          hit_points=victim[-2]
          victim[-2]=hit_points-damage
          update_ship_group(victim)
        end
      end 
      
      if (defeat(target_fleet))
        continue=false
      else
        if @fight_shield<0
          @fight_shield=0
        end
        if target_user==@attacker
          @attacker_shield=@fight_shield
        else
          @defender_shield=@fight_shield
        end
          round = round + 1
          tmp_fleet=turn_fleet
          tmp_user=turn_user
          turn_fleet=target_fleet
          turn_user=target_user
          target_fleet=tmp_fleet
          target_user=tmp_user
      end
      @report << round_report
    end
  end

  def fight
    init_vars
    report_start
    spy_phase
    emp_phase(@attacker)
    emp_phase(@defender)
    battle
    return @report
  end
end
