class ShipsStation < ActiveRecord::Base
  belongs_to :ship
  belongs_to :station

  def check_conditions
    return ship.user.check_condition(station.condition) && ship.check_condition(station.condition)
  end

  def get_upgrade_ratio
    if self.start_time == nil
      return 1.0
    else
      duration = self.get_duration(self.level).to_f
      past = Time.now - self.start_time
      ratio = 1.0 - (past / duration)
      if(ratio >= 0.1)
        return ratio
      else
        return 0.0
      end
    end
  end

  def get_duration(level)
    build_station_level = ShipsStation.find_by(:ship_id => ship.id, :station_id => 2005).level
    return (self.station.duration * 2 ** (level)) / (1 + 0.1 * build_station_level)
  end

  def get_refund
    station = self.station
    currentLevel = self.level

    ratio = self.get_upgrade_ratio
    reMetal = station.get_metal_cost_ratio(currentLevel, ratio)
    reCrystal = station.get_crystal_cost_ratio(currentLevel, ratio)
    reFuel = station.get_fuel_cost_ratio(currentLevel, ratio)

    back = ""
    back = back + "Rückzahlung beim Abbruch [" + ship.name + "]: <br>"
    back = back+"- Metal: "+reMetal.to_i.to_s+"<br>"
    back = back+"- Crystal: "+reCrystal.to_i.to_s+"<br>"
    back = back+"- Fuel: "+reFuel.to_i.to_s+"<br>"

    return back.html_safe
  end

  def level_cap_reached
    return false
  end

  def get_conditions()
    if(self.level_cap_reached)
      return "Level Max<br>".html_safe
    end

  	info = self.station.condition
  	conds = info.split(",")

    back = ""

  	conds.each do |cond|
  		c_info = cond.split(":")
  		typ = c_info[0]
  		id_geb = c_info[1].to_i
  		lvl = c_info[2]
  		
      case typ
      when "f"
        science = Science.find_by(:science_condition_id => id_geb)

        if not(ship.user_ship.user.has_min_science_level(science, lvl))
          back = back+"- Forschung: "+science.name+" "+lvl.to_s+"<br>"
        end
      when "g"
        station = Station.find_by(:station_condition_id => id_geb)

        if not(ship.has_min_station_level(station, lvl))
          back = back+"- Gebäude: "+station.name+" "+lvl.to_s+"<br>"
        end
      end
  	end

    leftMetal = station.get_metal_cost(self.level) - ship.metal.to_i
    leftCrystal = station.get_crystal_cost(self.level) - ship.cristal.to_i
    leftFuel = station.get_fuel_cost(self.level) - ship.fuel.to_i

    if(leftMetal > 0)
      back = back + "- Fehlendes Metall: " + leftMetal.to_s + "<br>"
    end

    if(leftCrystal > 0)
      back = back + "- Fehlende Kristalle: " + leftCrystal.to_s + "<br>"
    end

    if(leftFuel > 0)
      back = back + "- Fehlender Treibstoff: " + leftFuel.to_s + "<br>"
    end

    if(back.length != 0)
      back = "Voraussetzung: <br>" + back
    end

    if(!ship.enough_space(self))
      back = "Es werden mehr Ausbauplätze benötigt!<br>" + back
    end

    if(!ship.build_count_control)
      back = "Aktuell wird eine Station ausgebaut ...<br>" + back
    end

  	return back.html_safe
  end

  def reset_build
    self.start_time = nil
    self.save
    b = BuildList.find_by(typeSign: 's', instance_id: self.id)
    if b != nil
      b.destroy
    end
  end

end
