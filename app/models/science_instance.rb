class ScienceInstance < ActiveRecord::Base
  belongs_to :science
  belongs_to :user

  def get_time_since_research
    return (Time.now - self.updated_at).to_i
  end

  def get_research_ratio
    duration = self.science.get_duration(self.level).to_f
    past = self.get_time_since_research.to_f
    return 1.0 - (past/duration).to_f 
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
    cap =science.level_cap

    if cap < 0
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
  	if(user.is_researching())
      back = back + "Aktuell wird geforscht...<br>"
  	end

  	conds.each do |cond|
  		c_info = cond.split(":")
  		typ = c_info[0]
  		id_geb = c_info[1].to_i
  		lvl = c_info[2]
  		science = Science.find_by(:science_condition_id => id_geb)

      if not(user.has_min_science_level(science, lvl))
        back = back+"- Forschung: "+science.name+" "+lvl.to_s+"<br>"
      end
  	end
    
    leftMetal = science.get_metal_cost(self.level) - user.get_metal
    leftCrystal = science.get_crystal_cost(self.level) - user.get_crystal
    leftFuel = science.get_fuel_cost(self.level) - user.get_fuel

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
      back = "Voraussetzung: <br>"+back
    end

  	return back.html_safe
  end

  def update_time(format)
    science = Science.find_by(id: self.science_id)
    durationInSeconds = science.get_duration(self.level)

    if(self.start_time)
      timeSinceResearch = self.get_time_since_research
      restTime = durationInSeconds - timeSinceResearch

      if(restTime <= 0)
        self.level = self.level + 1
        self.start_time = nil
        self.save

        if not(format)
          return durationInSeconds;
        else
          return format_count_time(durationInSeconds)
        end
      else
        if not(format)
          return restTime;
        else
          return format_count_time(restTime)
        end
      end
    else
      if not(format)
        return durationInSeconds;
      else
        return format_count_time(durationInSeconds)
      end
    end
  end
end