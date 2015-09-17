class Fight< ActiveRecord::Base
  belongs_to :user
  belongs_to :attacker, :class_name => 'User', :foreign_key => 'attacker_id', inverse_of: :attacks
  belongs_to :defender, :class_name => 'User', :foreign_key => 'defender_id', inverse_of: :defends
  belongs_to :ship_attack, :class_name => 'Ship', :foreign_key => 'ship_attack_id', inverse_of: 'fight_attacks'
  belongs_to :ship_defend, :class_name => 'Ship', :foreign_key => 'ship_attack_id', inverse_of: 'fight_defends'
  has_one :fighting_fleet 

  def init_vars (attacker_fleet_id, defender_ship_id)
    if(!@allready_done)
      # Array in denen alle Ausgeben gespeichert werden
      @report = []
      @spy_report = []
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
      #Defender:
      @defender_ship = Ship.find(defender_ship_id)
      @defender = @defender_ship.user
      @attacker_fleet = FightingFleet.find(attacker_fleet_id)
      @attacker = @attacker_fleet.user
      @defender_fleet = get_fleet_by_ship(@defender_ship)
      @defender_level = build_level(@defender)
      @defender_station_level = build_station_level
      @defender_shield = shield_cal( @defender)
      @defender_facilities = build_defend_facilities(@defender_ship)
      @defender_origin_facility = safe_origin_facility_amount(@defender_facilities)
      @defender_lost = []
      # Attacker:
      @attacker_fleet = FightingFleet.find(attacker_fleet_id)
      @attacker = @attacker_fleet.user
      @attacker_ship = ship_attack
      @attacker_level = build_level(@attacker)
      @attacker_shield = shield_cal( @attacker)
      @attacker_lost = []
      @fight_shield = 0
      # Damit nur einmal initialisiert wird
      @allready_done = true  
    end    
  end

  # Baut ein Array von Anlagen anhand des Schiffes (Des Verteidigers)
  def build_defend_facilities(ship)
    array = []
    ship.facility_instances.each do |f|
      array << f
    end
    return array
  end

  # Findet Einheit anhand von Namen
  def find_id_unit (name)
    return Unit.find_by(name: name)
  end

  # Findet Station anhand von Namen
  def find_id_station (name)
    return Station.find_by(name: name)
  end 

  # Findet Forschung anhand von Namen
  def find_id_science (name)
    return Science.find_by(name: name)
  end

  # Findet Anlagen anhand von Namen
  def find_id_facility (name)
    return Facility.find_by(name: name)
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

  # Speichert die Anzahl einer Anlage
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
    if amount_of_ships(@attacker, @spy_ship_id) > 0
      # SPY_EVENT wird gestartet
      if random_to_one >  threshold_spy
        #Spyprobes leave battle!!
        spy_report_make(true, true)
        #STARTE EVENT
      else 
        #Spionage gescheitert
        spy_report_make(true, false)
      end
    else    #Spionage nicht gestartet
        spy_report_make(false, false)
    end
  end
  
  # Für die Ausgabe des Berichtes
  def spy_report_make(spy_start, spy_success)
    if spy_start
      if spy_success
        @spy_report << "Spionage erfolgreich! #{@defender.username} wurde ausspioniert."
        spy_event
      else
        @spy_report << "Spionage fehlgeschlagen! Spionagedrohnen von #{@attacker.username} wurden zerstört"
      end
    else 
        @spy_report << "Keine Spionagedrohnen verschickt. "
    end
  end

  # Welchen Bericht erhält angreifer, falls geglückte Spionage
  # MUSS NOCH ERWEITERT WERDEN!!!!!!!!
  def spy_event
    spy_level = user_science_level(@attacker, @spy_science_id)
    if spy_level >= 2
      if spy_level >= 8
        if spy_level >= 16
          @spy_report << spy_report_level_sixteen
        else  
          @spy_report << spy_report_level_eight
        end
      else   
      @spy_report << spy_report_level_two
      end
    else  
      @spy_report << []
    end
  end

  # Gibt den Spionagebericht ab Spionagelevel 2 wieder
  def spy_report_level_two
    return ["|", [" #{@defender.username} besitzt im Schiff #{@defender_ship.name}: #{get_sum_defender_ressources} Ressourcen, #{get_sum_defender_units} Einheiten und #{get_sum_defender_facilities} Anlagen." ]] 
  end

  # Gibt den Spionagebericht ab Spionagelevel 8 wieder  
  def spy_report_level_eight
    return ["|", get_list_defender_ressources,"|", get_list_defender_units,"|", get_list_defender_facilities]
  end

  def spy_report_level_sixteen
    return ["|",get_list_defender_ressources,"|", get_list_defender_units,"|", get_list_defender_facilities,"|", get_list_defender_sciences]
  end

  # Gibt den Spionagebericht ab Spionagelevel 16 wieder
  def get_list_defender_ressources
    ressource_report = []
    metal = @defender_ship.metal
    crystal = @defender_ship.cristal
    fuel = @defender_ship.fuel
    ressource_report << "#{@defender.username} besitzt im Schiff #{@defender_ship.name}: #{metal} Metall, #{crystal}Kristall und #{fuel} Treibstoff."
    return ressource_report
  end

  # Bildet Liste aller Defender-Einheiten
  def get_list_defender_units
    unit_report = []
    unit_report << "Auflistung der Flotte: "
    @defender_fleet.ship_groups.each do |group|
      unit_report << group.unit.name
      unit_report << group.number
    end
    return unit_report
  end

  # Bildet Liste aller Defender-Anlagen
  def get_list_defender_facilities
    unit_report = []
    unit_report << "Auflistung der Anlagen: "
    @defender_facilities.each do |instances|
      unit_report << instances.facility.name
      unit_report << instances.count
    end
    return unit_report
  end 

  # Bildet Liste aller Defender-Forschungen
  def get_list_defender_sciences
    unit_report = []
    unit_report << "Auflistung der Forschung: "
    @defender.science_instances.each do |science|
      unit_report << science.science.name
      unit_report << science.level
    end
    return unit_report
  end
  
  # Bildet die Summer aller Verteidiger-Ressourcen
  def get_sum_defender_ressources
    return @defender_ship.metal + @defender_ship.cristal + @defender_ship.fuel
  end

  # Bildet die Summer aller Verteider-Einheiten
  def get_sum_defender_units
    all_units = 0
    @defender_fleet.ship_groups.each do |group|
      all_units = all_units + group.number
    end
    return all_units
  end

  # Bildet die Summer aller Verteider-Anlagen
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
        # Passe Schilde an
        if user == @attacker
          @defender_shield = 0
        else
          @attacker_shield = 0
        end
      end
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
          # Berechne Schaden der Gruppe
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
        if a[1] > 0
          a[-1] = (a[-2].to_f/total_tp.to_f)
        end  
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
  def update_ship_group(group_array, user)
     if ( user == @attacker )
      array = @attacker_level
    else
      array = @defender_level
    end
    if group_array[-2] < 0
      group_array[-2] = 0
    end
    #Falls Einheit
    if (group_array[6])
      hp_one = Unit.find(group_array[0]).shell * @shell_mult * (1 + (0.1 * array[0])).to_i
      damage_one = Unit.find(group_array[0]).damage * @damage_mult * (1 + (0.1 * mult_weapon_level(group_array[3], user)))   
      # Falls Anlage 
    else
      hp_one = Facility.find(group_array[0]).shell * @shell_mult * (1 + (0.1 * array[0])).to_i
      damage_one = Facility.find(group_array[0]).damage * @damage_mult * (1 + (0.1 * mult_weapon_level(group_array[3], user)))
    end
      if group_array[1] > 0  
        amount_before = group_array[1]
        group_array[1] = (group_array[-2] / hp_one).ceil
        group_array[2] = group_array[1] * damage_one
        group_array[4] = amount_before - group_array[1]
      end  
    if group_array[1] < 0
       group_array[1] = 0
    end
    if group_array[-2] < 0
      group_array[-2] = 0
    end
  end

  # Berechnet das Schild von user
  def shield_cal(user)
    shield_mobile = amount_of_ships(user, @shield_ship_id) * 5
    level_shield = user_science_level(user, @shield_science_id) 
    shield_defend = 0
    if (user == @defender)
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

  # Baut ein Array mit allen Stations-Vorteilen
  def  build_station_level
    ship = Ship.find(@defender_ship)
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
      lost_array = @attacker_lost
    else
      origin = @defender_fleet
      facilities = @defender_facilities
      lost_array = @defender_lost
    end
    lost_report = []
    origin.ship_groups.each do |o|
      found = false
      lost = 0
      unit_report = []
      fleet_array.each do |a|     
        if a[1] > 0
          if o.unit_id == a[0]
            lost = o.number - a[1]
            found = true
          end
        end
      end
      unit_report << o.unit.name
      unit_report << o.number
      if found
        lost_array << [o.unit, lost, true]
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
        lost_array << [o.facility, lost, false]
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

  # Schnittstelle für Expedition
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
      turn_fleet.each do |fleet|
        # Nur Einheiten mit Anzahl > 0 und Schaden > 0 können kämpfen
        if fleet[1] > 0 && fleet[2] > 0    
          # Bestimme Ziel anhand von id.
          # -2 ist Miss
          # -1 ist Schild
          target = hit(target_fleet, turn_user)
          if(target==-1)
            mult = 1
            # Falls Ionenwaffe, wird Schaden an Schild erhöht
            if fleet[3] == 2
              mult = DamageType.find(fleet[3]).shield_mult
            end
            damage = fleet[2] * mult
            # Abzug des Schilds. Übernahme erst bei nächster Runde
            @fight_shield = @fight_shield - damage
            else
              mult = 1
              # Falls Laserwaffe, wird Schaden an Hülle erhöht
              # TABELLE DAMAGETYPE EINFÜGEN
              if (fleet[3] == 1)
                mult = DamageType.find(fleet[3]).shell_mult
              end 
               if fleet[3] == 3 and !fleet[6]
              mult = DamageType.find(fleet[3]).station_mult
              end
              if fleet[3] == 4 and fleet[0] == @plattform_id
              mult = DamageType.find(fleet[3]).plattform_mult
            end  
            # Bestimme welche Einheit getroffen wurde
            victim = target_fleet[target]
            # Schadensberechnung
            damage = fleet[2] * mult
            # Berechne neue HP
            hit_points = victim[-2]
            victim[-2] = hit_points-damage
            # Berechne Anzahl und Schaden neu
            update_ship_group(victim, target_user)
          end
        end 
      end
          # Füge Runden-Bericht ein
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
    defender_fleet_ary = []
    if turn_user == @attacker
      lost_report(turn_fleet, @attacker) 
      lost_report(target_fleet, @defender) 
      attacker_fleet_ary = turn_fleet
      defender_fleet_ary = target_fleet
    else
      lost_report(target_fleet, @attacker) 
      lost_report(turn_fleet, @defender) 

      attacker_fleet_ary = target_fleet
      defender_fleet_ary = turn_fleet
    end
    update_fighting_fleet(@attacker_fleet, attacker_fleet_ary)
    update_fighting_fleet(@defender_fleet, defender_fleet_ary)
    ary = [@attacker_fleet, @defender_fleet]   
    if victory
      calc_raid(attacker_fleet_ary)
    end
    return [@report, @spy_report]
  end
  
  # Berechnet den Raub bei Sieg des Angreifers
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
    if sum_max_raid == 0
      faktor = 0
    else  
      faktor = cargo_sum / sum_max_raid
    end
    if faktor > 1
      faktor = 1
    end
    @attacker_fleet.metal = max_raid[0] *  faktor
    @attacker_fleet.crystal = max_raid[1] *  faktor
    @attacker_fleet.fuel = max_raid[2] *  faktor
    @attacker_fleet.save
  end

  # Schreibt nach Kampf Verluste zurück
  def update_fighting_fleet(exsisting_fleet, array_of_fleet)
    max = array_of_fleet.length
    array_of_fleet.each do |a|  
      if a[6]
        unit = exsisting_fleet.ship_groups.find_by(:unit_id => a[0])
        if(unit.present?)
          unit.update(number: a[1])
          if exsisting_fleet.user == @defender
            instance = @defender_ship.get_unit_instance(unit.unit)
            instance.amount = a[1]
            instance.save
          end
        end
      else
        repair = @defender_station_level[-1]
        @defender_origin_facility.each do |o|
          if a[0] == o[0]
            a[1] += ((o[1] - a[1]) * repair).floor
            @defender_ship.facility_instances.find_by(:facility_id => a[0]).update(:count => a[1])
          end
        end    
      end
    end
    exsisting_fleet.save
    return exsisting_fleet     
  end

  # Speichert die Ursprünglichen Anlagen
  def safe_origin_facility_amount (facilities)
    array = []
    facilities.each do |f|
      array << [f.facility.id, f.count]
    end
    return array
  end
 
  # Suche Schiff anhand seiner id
  def get_ship_by_ship_id(ship_id_user)
    return UserShip.find_by(:ship_id => ship_id_user).ship
  end

  # Suche Benutzer anhand von Schiff
  def get_user_by_ship_id(ship_id_user)
    return UserShip.find_by(:ship_id => ship_id_user).user
  end

  # Berechne Totale Kosten einer Anlagenart
  def get_total_cost_by_facility (facility)
    metal = facility.cost1 
    crystal = facility.cost2 * 2
    fuel = facility.cost3 * 4
    return metal + crystal + fuel
  end  

  # Bilde Flotte aus Stationierten Einheiten anhand von Schiff
  def get_fleet_by_ship(ship_id_defender)
    fleet = FightingFleet.create(user: get_user_by_ship_id(ship_id_defender))
    fleet.ship_groups.each do |group|
      instance = Ship.find_by(:id => ship_id_defender).get_unit_instance(group.unit)
      group.number = instance.amount
      group.save
    end
    fleet.save
    return fleet
  end
  
  # Berechnet die Punkte anhand einer Flotte
  def get_total_points_fleet(fleet)
    points = 0
    fleet.ship_groups.each do |group|
      id = group.id
      group = ShipGroup.find(id)
      amount = group.number
      points += group.unit.get_total_cost * amount
    end
    return points/500
  end  

  # Berechnet die Punkte anhand von Anlagen
  def get_total_points_facilities_by_ship(ship)
    points = 0
    ship.facility_instances.each do |facility_instance|
      id = facility_instance.id
      facility_instance = FacilityInstance.find(id)
      points = points + get_total_cost_by_facility(facility_instance.facility)*facility_instance.count
    end
    return points/500
  end

  # Schnittstelle für Expeditionen mit Punkten
  def battle_with_points(attacker_fleet_id, defender_ship_id)
    init_vars(attacker_fleet_id, defender_ship_id)
    points_for_defender_before = get_total_points_fleet(@attacker_fleet)
    points_for_attacker_before = get_total_points_fleet(@defender_fleet)+ get_total_points_facilities_by_ship(@defender_ship)
    # Starte Kampf
    report = battle_id(attacker_fleet_id, defender_ship_id)
    points_for_defender_after = get_total_points_fleet(@attacker_fleet)
    points_for_defender = points_for_defender_before-points_for_defender_after
    points_for_attacker_after = get_total_points_facilities_by_ship(@defender_ship) +get_total_points_fleet(@defender_fleet)
    points_for_attacker = points_for_attacker_before-points_for_attacker_after
    update_points(@defender, points_for_defender) 
    @defender_fleet.destroy
    update_points(@attacker, points_for_attacker) 
    return report
  end

  # Update der Punkte 
  def update_points(user, points)
    points_of_user = user.rank.score 
    user.rank.update(:score => points_of_user+points)
  end

  # Hauptmethode. Navigiert durch den Kampf und gibt zum 
  # Schluss den Report zurück
  def fight(attacker_fleet_id, defender_ship_id)
    init_vars(attacker_fleet_id, defender_ship_id)
    spy_phase
    @defender.notifications.create(message: Message.find_by_code(1000),info: "Ihr Schiff "+@defender_ship.name+" wurde angegriffen von: " + @attacker.username)
    @attacker.notifications.create(message: Message.find_by_code(1000),info: "Ihre Truppen sind bei Schiff "+@defender_ship.name+" eingetroffen. Kampf gegen " + @defender.username + "!")
        # Verlustrechnung in Datenbank übernehmen
        battle_with_points(attacker_fleet_id, defender_ship_id)
        Fight.find(self.id).update(report: @report.to_s)        
        Fight.find(self.id).update(spy_report: @spy_report.to_s)        
        Fight.find(self.id).update(time: DateTime.now)  
        @defender_fleet.destroy      
        self.save        
    return @report
  end
end
