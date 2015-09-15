class Fight< ActiveRecord::Base
  belongs_to :user
  belongs_to :attacker, :class_name => 'User', :foreign_key => 'attacker_id', inverse_of: :attacks
  belongs_to :defender, :class_name => 'User', :foreign_key => 'defender_id', inverse_of: :defends
  belongs_to :ship_attack, :class_name => 'Ship', :foreign_key => 'ship_attack_id', inverse_of: 'fight_attacks'
  belongs_to :ship_defend, :class_name => 'Ship', :foreign_key => 'ship_attack_id', inverse_of: 'fight_defends'
  has_one :fighting_fleet 

  def init_vars (attacker_fleet_id, defender_ship_id)
    if(!@allready_done)
      # Array in dem alle Ausgeben gespeichert werden
      @report = []
      @testout = []
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
      @metal_vault_id =find_id_station ("Ressourcentresor Metall")
      @crystal_vault_id =find_id_station ("Ressourcentresor Kristall")
      @fuel_vault_id =find_id_station ("Ressourcentresor Treibstoff")
      @repair_id =find_id_station ("Reparaturgebäude")
      # Faktoren
      @shell_mult = 100
      @damage_mult = 1
      @cargo_mult = 100
      @defender_ship = Ship.find(defender_ship_id)
      # Speichert Flotten
      @attacker_fleet = FightingFleet.find(attacker_fleet_id)
      # Speichert Angreifer und Verteidiger
      @attacker = @attacker_fleet.user
      @defender = @defender_ship.user
      @attacker_ship = ship_attack
      @defender_fleet = get_fleet_by_ship(@defender_ship)
       # MUSS NOCH ANGEPASST WERDEN
      # Speichert alle notwendigen Forschungslevel
      @attacker_level = build_level(@attacker)
      @defender_level = build_level(@defender)
      @defender_station_level = build_station_level
      # Speichert die Schilde
      @attacker_shield = shield_cal( @attacker)
      @defender_shield = shield_cal( @defender)
      @defender_facilities = build_defend_facilities(@defender_ship)
      @defender_origin_facility = safe_origin_facility_amount (@defender_facilities)
      @fight_shield = 0
      @allready_done = true 
      byebug

   end    
  end
  
  def find_ship_by_ship_id (ship_id)
    return Ship.find(ship_id)
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

  def find_id_station (name)
    return Station.find_by(name: name)
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
      return @attacker_fleet.ship_groups.find_by(unit_id: unit_id).number
  end

  def amount_of_facilities(facility_id)
    amount = 0
    if  (@defender_facilities.nil?)
      return 0
    end
    @defender_facilities.each do |f|
      if f.facility_id == facility_id
        amount = f.count
      end
    end 
    return amount
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
     @report << spy_report_level_two
      if spy_level >= 8
        @report << spy_report_level_eight
        if spy_level >= 16
          @report << spy_report_level_sixteen
        end
      end
      else
      #Spionagelevel zu niedrig.
    end
  end

  def spy_report_level_two
    return ["Spionagebericht: ", [" #{@defender.username} besitzt im Schiff #{@defender_ship.name}: #{get_sum_defender_ressources} Ressourcen, #{get_sum_defender_units} Einheiten und #{get_sum_defender_facilities} Anlagen." ]] 
  end
  
  def spy_report_level_eight
    return ["Spionagebericht: ", get_list_defender_ressources, get_list_defender_units, get_list_defender_facilities]
  end

  def spy_report_level_sixteen
    return ["Spionagebericht: ",get_list_defender_ressources, get_list_defender_units, get_list_defender_facilities, get_list_defender_sciences]
  end

  def get_list_defender_ressources
    ressource_report = []
    metal = @defender_ship.metal
    crystal = @defender_ship.cristal
    fuel = @defender_ship.fuel
    ressource_report << "#{@defender.username} besitzt im Schiff #{@defender_ship.name}: #{metal} Metall, #{crystal}Kristall #{fuel}und Treibstoff"
    return ressource_report
  end

  def get_list_defender_units
    unit_report = []
    unit_report << "Auflistung der Flotte: "
    @defender_fleet.ship_groups.each do |group|
      unit_report << group.unit.name
      unit_report << group.number
    end
    return unit_report
  end 

  def get_list_defender_facilities
    unit_report = []
    unit_report << "Auflistung der Anlagen: "
    @defender_facilities.each do |instances|
      unit_report << instances.facility.name
      unit_report << instances.count
    end
    return unit_report
  end 

  def get_list_defender_sciences
    unit_report = []
    unit_report << "Auflistung der Forschung: "
    @defender.science_instances.each do |science|
      unit_report << science.science.name
      unit_report << science.level
    end
    return unit_report
  end
  
  def get_sum_defender_ressources
    return @defender_ship.metal + @defender_ship.cristal + @defender_ship.fuel
  end

  def get_sum_defender_units
    all_units = 0
    @defender_fleet.ship_groups.each do |group|
      all_units = all_units + group.number
    end
    return all_units
  end

  def get_sum_defender_facilities
    all_facilities = 0
    @defender_facilities.each do |instance|
    all_facilities = all_facilities + instance.count
    end
    return all_facilities
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
    defence = true
    if ( user == @attacker )
      array = @attacker_level
      defence = false
    else
      array = @defender_level
      defence = true
    end
    fleet_array = []
      # Sammelt nötige Werte und speichert diese als Array in Array
      fleet.ship_groups.each do |sg|
        # Falls Gruppe leer, überspringe
        amount = sg.get_number
        id = sg.get_id
        if id != @spy_ship_id 
          damage_sum = sg.get_damage * amount * @damage_mult
          damage_type = sg.get_damage_type
          hp_sum = (sg.get_hp * amount * (1 + (0.1 * array[0])).to_i) * @shell_mult
          hitchance = 0.0
          damage_sum = damage_sum*(1 + (0.1 * mult_weapon_level(damage_type, user)))
          lost_ships = 0
          name = sg.get_name 
          cargo = sg.get_cargo * @cargo_mult
          # Speichert alle Werte in Array
          fleet_array << [id, amount, damage_sum, damage_type, lost_ships, name, true, cargo, hp_sum, hitchance]
        end
      end
    # Falls Spieler Verteidiger ist, erhält er noch seine Anlagen  
    if(defence)
      @defender_facilities.each do|f|
        amount = f.count
        id = f.facility.id
        damage_sum = f.facility.damage * amount * @damage_mult
        damage_type = f.facility.damage_type.id
        hp_sum = (f.facility.shell * amount * (1 + (0.1 * array[0])).to_i) *@shell_mult
        hitchance = 0.0
        damage_sum = damage_sum * (1 + (0.1 * mult_weapon_level(damage_type, user)))  
        lost_facilities = 0
        name = f.facility.name
        cargo = 0 
        # Speichert alle Werte in Array
          fleet_array << [id, amount, damage_sum, damage_type, lost_facilities, name, false, cargo, hp_sum, hitchance]
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
  def update_ship_group(group_array)
    if group_array[-2] < 0
      group_array[-2] = 0
    end
    if (group_array[6])
      hp_one = Unit.find(group_array[0]).shell * @shell_mult
      damage_one = Unit.find(group_array[0]).damage * @damage_mult
      
    else
      hp_one = Facility.find(group_array[0]).shell * @shell_mult
      damage_one = Facility.find(group_array[0]).damage * @damage_mult
    end  
      amount_before = group_array[1]
      group_array[1] = (group_array[-2] / hp_one).ceil
      group_array[2] = group_array[1] * damage_one
      group_array[4] = amount_before - group_array[1]
    if group_array[1] < 0
       group_array[1] = 0
    end
  end


  # Berechnet das Schild von user
  # MUSS NOCH ANGEPASST WERDEN!!!!!!!!!!!!!!!!
  def shield_cal(user)
    shield_mobile = amount_of_ships(user, @shield_ship_id) * 5
    level_shield = user_science_level(user, @shield_science_id) 
    shield_defend = 0
    if (user == @defender)
      #add shield
      # ANLAGEN NOCH EINBINDEN!!!!!!
      shield_big = amount_of_facilities(@big_shield_id ) * 500
      shield_small = amount_of_facilities(@smal_shield_id ) * 100
      shield_defend = shield_big + shield_small
    end
    return (shield_mobile + shield_defend) * (1 + 0.1 * level_shield)
  end
  
  # Baut ein Array mit allen Forschungsleveln des Benutzers
  def build_level(user)
    shell = user_science_level(user, @shell_science_id)
    shield = user_science_level(user, @shield_science_id)
    laser = user_science_level(user, @laser_science_id)
    ionen = user_science_level(user, @ionen_science_id)
    bomb = user_science_level(user, @bomb_science_id)
    pilot = user_science_level(user, @pilot_science_id)
    spy = user_science_level(user, @spy_science_id)
    return [shell, shield, laser, ionen, bomb, pilot, spy]
  end

  def  build_station_level
    ship = Ship.find(ship_defend_id)
    metal_save = 2000 * (2 ** ship.ships_stations.find_by(station_id: @metal_vault_id).level)
    crystal_save = 2000 * (2 **  ship.ships_stations.find_by(station_id: @crystal_vault_id).level)
    fuel_save =2000 * (2 **  ship.ships_stations.find_by(station_id: @fuel_vault_id).level)
    repair = (0.5 - (0.5/(1+ 0.1 * ship.ships_stations.find_by(station_id: @repair_id).level)))
    return [metal_save, crystal_save, fuel_save, repair]
  end

  # Für den Verlust-Report nach der Schlacht
  def lost_report (fleet_array, user)

    if (user == @attacker)
      origin = @attacker_fleet
    else
      origin = @defender_fleet
      facilities = @defender_facilities
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
    if (user==@defender)
      facilities.each do |o|
        found = false
        lost = 0
        unit_report = []
        fleet_array.each do |a|
          if o.facility_id == a[0]
            lost = o.count - a[1]
            found = true
          end
          
        end
        unit_report << o.facility.name
        unit_report << o.count
        if found
          unit_report << lost
          unit_report << (o.count - lost)
        else 
          unit_report << o.count
          unit_report << 0
        end
        lost_report << unit_report
      end
    end  
    @report << lost_report
  end

  def battle_id(fleet_id, ship_id_defender)
      init_vars(fleet_id ,ship_id_defender)
      return battle
  end

  # Zum berechnen des Kampfes
  def battle
    # Runden auf 0 setzen, continue auf true (Für die Schleife)
    round = 0
    continue = true
    victory = false
    # Bilde Arrays mit allen nötigen Werten für den Kampf
    turn_fleet = build_array(@attacker, @attacker_fleet)
    target_fleet = build_array(@defender, @defender_fleet)
    emp_phase(@attacker)
    emp_phase(@defender)
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
      round_report << "Runde #{round}: "
      round_report << "#{turn_user.username} ist am Zug."
      if shield > 0
        round_report << "Schild von #{target_user.username} ist aktiv."
        round_report << "Schild hält noch #{shield} Schaden aus."
        round_report << "Alle Truppen schießen auf den Schild!"
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
              mult = 1
              # Falls Laserwaffe, wird Schaden an Hülle erhöht
              # TABELLE DAMAGETYPE EINFÜGEN
              if(a[3] == 1)
                mult = 1.5
              end 
            # Bestimme welche Einheit getroffen wurde
            victim = target_fleet[target]
            round_report << "#{victim[5]}. Der Schaden beträgt:  "
            # Schadensberechnung
            damage = a[2]*mult
            round_report << "#{damage} "
            # Berechne neue HP
            hit_points = victim[-2]
            victim[-2] = hit_points-damage
            # Berechne Anzahl und Schaden neu
            update_ship_group(victim)
            round_report << "#{victim[4]} Einheiten wurden zerstört. "
          end
        end 
      end
          # Füge Runden-Bericht ein
          @round_reports << round_report
      # Testet, ob Spieler noch Truppen besitzt
      if (defeat(target_fleet))
        continue = false
        if turn_user == @attacker
          victory = true  
        end
      else
        # Falls Schild unter 0, wird er auf 0 gesetzt
        if @fight_shield < 0
          @fight_shield = 0
        end
        # Kampf-Schild für nächste Runde
        if target_user == @attacker
          @attacker_shield = @fight_shield
        else
          @defender_shield = @fight_shield
        end
          # Tausche Rolle des Angreifers aus
          tmp_fleet = turn_fleet
          tmp_user = turn_user
          turn_fleet = target_fleet
          turn_user = target_user
          target_fleet = tmp_fleet
          target_user = tmp_user
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

    attacker_fleet_ary = []
    deffender_fleet_ary = []


    if turn_user == @attacker
      lost_report(turn_fleet, @attacker) 
      lost_report(target_fleet, @defender) 
      attacker_fleet_ary = turn_fleet
      deffender_fleet_ary = target_fleet

    else
      lost_report(target_fleet, @attacker) 
      lost_report(turn_fleet, @defender) 

      attacker_fleet_ary = target_fleet
      deffender_fleet_ary = turn_fleet
    end

    update_fighting_fleet(@attacker_fleet, attacker_fleet_ary)
    update_fighting_fleet(@defender_fleet, deffender_fleet_ary)
    # ANLAGEN NOCH EINFÜGEN:
    ary = [@attacker_fleet, @defender_fleet]   

    if victory
      calc_raid(attacker_fleet_ary)
    end

    return ary
  end
  
  def calc_raid(attacker_fleet_array)
    max_raid = []
    max_raid << @defender_ship.metal - @defender_station_level[0]
    max_raid << @defender_ship.cristal - @defender_station_level[1]
    max_raid << @defender_ship.fuel - @defender_station_level[2]
    i = 0
    sum_max_raid = 0
    while i < 2 do
      if max_raid[i] < 0
        max_raid[i] = 0
      end
      sum_max_raid = sum_max_raid + max_raid[i]
      i = i + 1
    end
    cargo_sum = 0
    attacker_fleet_array.each do |a|
      cargo_sum = cargo_sum + a[7]
    end
    faktor = cargo_sum / sum_max_raid
    if faktor > 1
      faktor = 1
    end
    @testout << @attacker_fleet.metal = max_raid[0] *  faktor
    @testout << @attacker_fleet.crystal = max_raid[1] *  faktor
    @testout << @attacker_fleet.fuel = max_raid[2] *  faktor
    @attacker_fleet.save
  end

  def update_fighting_fleet(exsisting_fleet, array_of_fleet)
    array_of_fleet.each do |a|  
      if a[6]
        exsisting_fleet.ship_groups.find_by(:unit_id => a[0]).update(:number => a[1])
      else
        repair = @defender_station_level[-1]
        lost = 0
        restore = 0
        @defender_origin_facility.each do |o|
          if (a[0] == o[0])
            lost = o[1] - a[1]
            total_cost_one =  get_total_cost_by_facility (Facility.find(o[0]))
            total_cost_all = total_cost_one * lost
            restore = (total_cost_all / total_cost_one).floor.to_i
          end
          
          @defender_ship.facility_instances.find_by(:facility_id => a[0]).update(:count => restore)
        end    
      end
    end     
  end

  def safe_origin_facility_amount (facilities)
    array = []
    facilities.each do |f|
      array << [f.facility.id, f.count]
    end
    return array
  end
 
  def get_ship_by_ship_id(ship_id_user)
    return UserShip.find_by(:ship_id => ship_id_user).ship
  end

  def get_user_by_ship_id(ship_id_user)
    return UserShip.find_by(:ship_id => ship_id_user).user
  end
  # Hauptmethode. Navigiert durch den Kampf und gibt zum 
  # Schluss den Report zurück
  

  def get_fleet_by_ship(ship_id_deffender)
    fleet = FightingFleet.create(user: get_user_by_ship_id(ship_id_deffender))
    fleet.ship_groups.each do |group|
      instance = Ship.find_by(:id => ship_id_deffender).get_unit_instance(group.unit)
      group.number = instance.amount
      group.save
    end
    fleet.save
    return fleet
  end

  def get_total_points_fleet(fleet)
    points = 0
    fleet.ship_groups.each do |group|
      amount = group.number
      points += group.unit.get_total_cost * amount
    end
    return points/500
  end  

  def get_total_points_facilities_by_ship(ship)
    points = 0
    ship.facility_instances.each do |facility_instance|
      points = points + get_total_cost_by_facility(facility_instance.facility)*facility_instance.count
    end
    return points/500
  end

  def get_total_cost_by_facility (facility)
    metal = facility.cost1 
    crystal = facility.cost2 * 2
    fuel = facility.cost3 * 4
    return metal + crystal + fuel
  end  

  def fight(attacker_fleet_id, defender_ship_id)
    init_vars(attacker_fleet_id, defender_ship_id)
    report_start
    spy_phase
    
    battle_with_points(attacker_fleet_id, defender_ship_id)

    # Verlustrechnung in Datenbank übernehmen
    return @testout
  end

  def battle_with_points(attacker_fleet_id, defender_ship_id)
    init_vars(attacker_fleet_id, defender_ship_id)
    points_for_defender_before = get_total_points_fleet(@attacker_fleet)
    points_for_attaker_before = get_total_points_fleet(@defender_fleet)+ get_total_points_facilities_by_ship(@defender_ship)
    # Starte Kampf
    battle_id(attacker_fleet_id, defender_ship_id)
    points_for_defender_after = get_total_points_fleet(@attacker_fleet)
    points_for_attaker_after = get_total_points_facilities_by_ship(@defender_ship)
    points_for_attaker_after += get_total_points_fleet(@defender_fleet)
    points_for_defender = points_for_defender_before-points_for_defender_after
    @testout << points_for_attaker_after
    @testout << points_for_attaker_before
    points_for_attaker = points_for_attaker_before-points_for_attaker_after
    update_points(@defender, points_for_defender) 
    update_points(@attacker, points_for_attaker) 
  end

  def update_points(user, points)
    points_of_user = user.rank.score 
    user.rank.update(:score => points_of_user+points)
    #user.incr_user_rank(points)
  end
end
