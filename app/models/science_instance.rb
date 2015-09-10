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
    back = back + "Refund: <br>"
    back = back+"- Metal: "+reMetal.to_i.to_s+"<br>"
    back = back+"- Crystal: "+reCrystal.to_i.to_s+"<br>"
    back = back+"- Fuel: "+reFuel.to_i.to_s+"<br>"

    return back.html_safe
  end

  def get_conditions()
  	info = self.science.condition
  	conds = info.split(",")

    back = ""
  	if(user.is_researching())
      back = back + "Aktuell wird geforscht...<br>"
  	end
  	back = back + "Voraussetzung: <br>"
  	conds.each do |cond|
  		c_info = cond.split(":")
  		typ = c_info[0]
  		id_geb = c_info[1].to_i
  		lvl = c_info[2]
  		name = Science.find_by(:science_condition_id => id_geb).name
  		back = back+"- Forschung: "+name+" "+lvl.to_s+"<br>"
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
  	return back.html_safe
  end
end
