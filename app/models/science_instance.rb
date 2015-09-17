class ScienceInstance < ActiveRecord::Base
  belongs_to :science
  belongs_to :user

  def check_conditions
    ship = Ship.find_by(:id => research_ship || user.activeShip)
    return user.check_condition(self.science.condition) && ship.check_condition(self.science.condition)
  end

  def get_research_ratio
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
    research_station_level = ShipsStation.find_by(:ship_id => research_ship || user.activeShip, :station_id => 2004).level
    if(self.research_amount != 0)
      research_station_level = self.research_amount
    end
    return (self.science.duration * self.science.factor ** (level + 1)) / (1 + 0.1 * research_station_level)
  end

  def get_refund
    science = self.science
    currentLevel = self.level

    ratio = self.get_research_ratio
    reMetal = science.get_metal_cost_ratio(currentLevel, ratio)
    reCrystal = science.get_crystal_cost_ratio(currentLevel, ratio)
    reFuel = science.get_fuel_cost_ratio(currentLevel, ratio)

    back = ""
    if not(self.research_ship.nil?)
      back = back + "Rückzahlung beim Abbruch [" + (Ship.find_by(:id => self.research_ship)).name + "]: <br>"
    end
    back = back + "- Metall: "+reMetal.to_i.to_s+"<br>"
    back = back + "- Kristalle: "+reCrystal.to_i.to_s+"<br>"
    back = back + "- Treibstoff: "+reFuel.to_i.to_s+"<br>"

    return back.html_safe
  end

  def level_cap_reached
    lvl = self.level
    cap = science.level_cap

    if cap.blank?
      return false
    end

    return lvl >= cap
  end

  def get_conditions
    if(self.level_cap_reached)
      return "Level Max<br>".html_safe
    end

  	info = self.science.condition
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

        if not(user.has_min_science_level(science, lvl))
          back = back+"- Forschung: "+science.name+" "+lvl.to_s+"<br>"
        end
      when "g"
        station = Station.find_by(:station_condition_id => id_geb)

        if not(user.active_ship.has_min_station_level(station, lvl))
          back = back+"- Gebäude: "+station.name+" "+lvl.to_s+"<br>"
        end
      end
  	end

    leftMetal = science.get_metal_cost(self.level) - user.get_metal.to_i
    leftCrystal = science.get_crystal_cost(self.level) - user.get_crystal.to_i
    leftFuel = science.get_fuel_cost(self.level) - user.get_fuel.to_i

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

    if(user.is_researching(self) || !user.research_count_control)
      back = "Aktuell wird geforscht...<br>" + back
    end

  	return back.html_safe
  end

  def reset_build
    self.start_time = nil
    self.research_ship = nil
    self.research_amount = 0
    self.save
    BuildList.where(typeSign: 'n', instance_id: self.id).each do |b|
      b.destroy
    end
    b = BuildList.find_by(typeSign: 'r', instance_id: self.id)
    if b != nil
      b.destroy
    end
  end

end
