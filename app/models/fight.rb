class Fight< ActiveRecord::Base
  belongs_to :user
  belongs_to :attacker, :class_name => 'User', :foreign_key => 'attacker_id', inverse_of: :attacks
  belongs_to :defender, :class_name => 'User', :foreign_key => 'defender_id', inverse_of: :defends
  belongs_to :ship_attack, :class_name => 'Ship', :foreign_key => 'fight_attack_id', inverse_of: 'fight_attacks'
  belongs_to :ship_defend, :class_name => 'Ship', :foreign_key => 'fight_attack_id', inverse_of: 'fight_defends'
  has_one :fighting_fleet 

  def init_vars
    # Array in dem alle Ausgeben gespeichert werden
    @report = []
    # Array für die einzelnden Runden
    @round_reports = []
    # IDs
    @spy_science_id = find_id_science ("Spionage")
    @pilot_science_id = find_id_science ("Pilotentraining")
    @shell_science_id = find_id_science ("Hülle")
    @laser_science_id = find_id_science ("Laser")
    @ionen_science_id = find_id_science ("Ionen")
    @shield_science_id = find_id_science ("Schild")
    @bomb_science_id = find_id_science ("Kinetik")
    @emp_ship_id = find_id_unit ("EMP-Schiff")
    @spy_ship_id = find_id_unit ("Spionagedrohne")
    @shield_ship_id = find_id_unit ("Mobiler Schild")
    @small_shield_id = find_id_facility ("Kleiner Schild")
    @big_shield_id = find_id_facility ("Großer Schild")
    @plattform_id = find_id_facility ("Orbitale Waffenplattform")
    # Speichert Angreifer und Verteidiger
    @attacker = attacker
    @defender = defender
    # Speichert Flotten
    @attacker_fleet = fighting_fleet
    @defender_fleet = FighingFleet.first
    @defender_facilities = build_defend_facilities(Ship.find(ship_defend_id)) # MUSS NOCH ANGEPASST WERDEN
    # Speichert alle notwendigen Forschungslevel
    @attacker_level = build_level(@attacker)
    @defender_level = build_level(@defender)
    # Speichert die Schilde
    @attacker_shield = shield_cal( @attacker)
    @defender_shield = shield_cal( @defender)
    @fight_shield = 0
  end
  
  def build_defend_facilities(ship)
    array = []
    ship.facility_instances.each do |f|
      array << f
    end
    return array
  end

  def find_id_unit (name)
    return Unit.find_by(name: name)
  end 

  def find_id_science (name)
    return Science.find_by(name: name)
  end

  def find_id_facility (name)
    return Facility.find_by(name: name)
  end

  # Lädt den Titel mit Agreifer und Verteidiger in den Kampfbericht 
  def report_start
   @report << "Kampfbericht:" 
   @report << " Angreifer: #{self.attacker.username} Verteidiger: #{self.defender.username} "
  end
  
  # Fragt Forschungslevel des Spielers ab
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
      return @attacker_fleet.ship_groups.find_by(unit_id: unit_id).number
    elsif (user ==@defender)
      # MUSS NOCH ANGEPASST WERDEN!!!!!!!!!EINSELF
      # HIER NOCH ANLAGEN EINBINDEN
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
  def get_x_for_random(user)
    array= []
    # Bestimme für wen der Schwellenwert berechnet wird
    if user == @attacker
      array = @attacker_level
    else
      array = @defender_level
    end
    # Berechnet maximale Schwelle
    x = (1.3 - (0.01 * array[5].to_f))
    # Kann nicht unter 1 Fallen
    if x < 1
      x = 1
    end
    return x
  end

  # Zufallszahl zwischen 0 und x
  def random_to_x(user)
    return (rand (0 .. (get_x_for_random(user).to_f)))
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
      @report << "Spionagebericht: "
      if spy_success
        @report << "Spionage erfolgreich! #{@defender.username} wurde ausspioniert."
        spy_event
      else
        @report << "Spionage fehlgeschlagen! Spionagedrohnen von #{@attacker.username} wurden zerstört"
      end
    else 
        @report << " "
        @report << " "
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
    # Hat der Nutzer EMP-Schiffe geschickt?
    if amount_of_ships(user, @emp_ship_id) > 0
      # Glückt EMP?   
      if threshold_emp(user) > random_to_one
        emp_report(user, true, true)
        # Passe Schilde an
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
        @report << " "
        @report << " "
    end  
  end
  
  # Testet, ob eine Flotte noch Schiffe hat und löscht leere Schiffsgruppen
  def defeat(fleet)
    count_all_ships = 0
    fleet_new = []
    # Zählt ob noch Schiffe vorhanden sind
    fleet.each do |a|
      count_all_ships = count_all_ships + a[2]
      # Nur Gruppen mit Schiffen werden für Berechnung übernommen
      if a[1] > 0
        fleet_new << a
      end
    end
    # Speichert angepasste Flotte
    fleet = fleet_new
    get_hitchances(sort_by_damage(fleet))
    return count_all_ships == 0
  end


  # Baut ein Array mit allen Schiffsgruppen des Spielers user aus der
  # Flotte fleet
  def build_array ( user, fleet )
    # Wählt Level-Array für jeweiligen Nutzer aus
    defence true
    if ( user == @attacker )
      array = @attacker_level
      defence false
    else
      array = @defender_level
    end
    fleet_array = []
    # Sammelt nötige Werte und speichert diese als Array in Array
    fleet.ship_groups.each do |sg|
      # Falls Gruppe leer, überspringe
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
        # Speichert alle Werte in Array
        fleet_array << [id, amount, damage_sum, damage_type, lost_ships, name, true, hp_sum, hitchance]
      end
    end
    if(defence)
      defender_facilities.each do|f|
       
        # Falls Gruppe leer, überspringe
        amount = f.count
        if (amount > 0)
          id = f.id
          #### AB HIER NOCH ERGÄNZEN
          damage_sum = f. * amount
          damage_type = sg.get_damage_type
          hp_sum = sg.get_hp * amount * (1 + (0.1 * array[0])).to_i
          hitchance = 0.0
          damage_sum = damage_sum*(1 + (0.1 * mult_weapon_level(damage_type, user)))
          lost_ships = 0
          name = sg.get_name 
          # Speichert alle Werte in Array
          fleet_array << [id, amount, damage_sum, damage_type, lost_ships, name, true, hp_sum, hitchance]
        end
      end
    end
    # Sortiere Array und Berechne Trefferwahrscheinlichkeiten
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
    if (fleet_array.length > 0 )
      total_tp = 0
      fleet_array.each do |a|
        total_tp = total_tp + a[-2]
      end
      fleet_array.each do |a|
        a[-1] = (a[-2].to_f/total_tp.to_f)
      end
    end
  end
  
  # Berechnet, welche Schiffsgruppe getroffen wurde
  # -1 ist Schild
  # -2 ist Miss
  def hit(enemy_fleet_array, user)
    index = 0
    hit_index = random_to_x(user)
    if (hit_index <= 1)
      if (@fight_shield > 0)
        return -1
      end
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
 
  # Bringt die Daten der Schiffsgruppe nach Angriff auf neusten Stand
  def update_ship_group(group)
    if group[-2] < 0
      group[-2] = 0
    end
    amount_before = group[1]
    hp_one = Unit.find(group[0]).shell
    damage_one = Unit.find(group[0]).damage
    group[1] = (group[-2] / hp_one).ceil
    group[2] = group[1] * damage_one
    group[4] = amount_before - group[1]
    if group[1] < 0
      group[1] = 0
    end
  end


  # Berechnet das Schild von user
  # MUSS NOCH ANGEPASST WERDEN!!!!!!!!!!!!!!!!
  def shield_cal(user)
    amount = amount_of_ships(user, @shield_ship_id)
    level_shield=user_science_level(user, @shield_science_id) 
    if (user == @defender)
      #add shield
      # ANLAGEN NOCH EINBINDEN!!!!!!
    end
    return 10000
  end
  
  # Baut ein Array mit allen Forschungsleveln des Benutzers
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

  # Für den Verlust-Report nach der Schlacht
  def lost_report (fleet_array, user)
    if (user == @attacker)
      origin = @attacker_fleet
    else
      origin = @defender_fleet
    end
    lost_report = []
    origin.ship_groups.each do |o|
      found = false
      lost = 0
      unit_report = []
      fleet_array.each do |a|
        if o.unit_id == a[0]
          lost = o.number - a[1]
          found = true
        end
      end
      unit_report << o.unit.name
      unit_report << o.number
      if found
        unit_report << lost
        unit_report << (o.number - lost)
      else 
        unit_report << o.number
        unit_report << 0
      end
      lost_report << unit_report
    end
    @report << lost_report
  end

  # Zum berechnen des Kampfes
  def battle
    # Runden auf 0 setzen, continue auf true (Für die Schleife)
    round = 0
    continue = true
    # Bilde Arrays mit allen nötigen Werten für den Kampf
    turn_fleet = build_array(@attacker, @attacker_fleet)
    target_fleet = build_array(@defender, @defender_fleet)
    # Angreifer beginnt
    turn_user = @attacker
    target_user = @defender
    while (round < 1000 && continue  ) do
      round = round + 1
      if target_user == @defender
        @fight_shield = @defender_shield
      else
        @fight_shield = @attacker_shield
      end
      # Damit alle Gruppen in einer Runde nur auf das Schild feuern können
      shield = @fight_shield
      # Für die Ausgabe der Runden-Berichte
      round_report = []
      round_report << "Runde #{round+1}: "
      round_report << "#{turn_user.username} ist am Zug."
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
        # Nur Einheiten mit Anzahl > 0 und Schaden > 0 können kämpfen
        if a[1] > 0 && a[2] > 0   
          round_report << "Die Gruppe #{a[5]} trifft... "
          # Bestimme Ziel anhand von id.
          # -2 ist Miss
          # -1 ist Schild
          target = hit(target_fleet, turn_user)
          if(target == -2)
            round_report << "nicht. Der Angriff ging daneben. "
            round_report << " "
            round_report << " "
          elsif(target==-1)
            round_report << "das Schild. Der Schaden beträgt:  "
            mult = 1
            # Falls Ionenwaffe, wird Schaden an Schild erhöht
            if a[3] == 2
              mult = 1.5
            end
            damage = a[2] * mult
            round_report << "#{damage} "
            round_report << " "
            # Abzug des Schilds. Übernahme erst bei nächster Runde
            @fight_shield = @fight_shield - damage
            else
              mult=1
              # Falls Laserwaffe, wird Schaden an Hülle erhöht
              # TABELLE DAMAGETYPE EINFÜGEN
              if(a[3]==1)
                mult=1.5
              end 
            # Bestimme welche Einheit getroffen wurde
            victim=target_fleet[target]
           # round_report << "#{victim[5]}. Der Schaden beträgt:  "
            # Schadensberechnung
            damage=a[2]*mult
            round_report << "#{damage} "
            # Berechne neue HP
            hit_points=victim[-2]
            victim[-2]=hit_points-damage
            # Berechne Anzahl und Schaden neu
            update_ship_group(victim)
            round_report << "#{victim[4]} Einheiten wurden zerstört. "
          end
        end 
        # Füge Runden-Bericht ein
       # @round_reports << round_report
      end
      # Testet, ob Spieler noch Truppen besitzt
      if (defeat(target_fleet))
        continue=false
      else
        # Falls Schild unter 0, wird er auf 0 gesetzt
        if @fight_shield < 0
          @fight_shield = 0
        end
        # Kampf-Schild für nächste Runde
        if target_user==@attacker
          @attacker_shield=@fight_shield
        else
          @defender_shield=@fight_shield
        end
          # Tausche Rolle des Angreifers aus
          tmp_fleet=turn_fleet
          tmp_user=turn_user
          turn_fleet=target_fleet
          turn_user=target_user
          target_fleet=tmp_fleet
          target_user=tmp_user
      end
      # Füge alle Runden-Berichte hinzu
      @report << @round_reports
    end
    if continue
      @report << "Unentschieden! "
      @report << "Es konnte kein Sieger ermittelt werden "
    else 
      @report << "Die Flotte von #{target_user.username} unterlag. "
      @report << " #{turn_user.username} war siegreich! "
    end
    # Generiere Verlustrechnung
    if turn_user == @attacker
      lost_report(turn_fleet, @attacker) 
      lost_report(target_fleet, @defender) 
    else
      lost_report(target_fleet, @attacker) 
      lost_report(turn_fleet, @defender) 
    end
  end

  # Hauptmethode. Navigiert durch den Kampf und gibt zum 
  # Schluss den Report zurück
  def fight
    init_vars
    report_start
    spy_phase
    emp_phase(@attacker)
    emp_phase(@defender)
    battle
    # Verlustrechnung in Datenbank übernehmen
    return @report
  end
end
