require 'TimeFormatter'

class UnitInstance < ActiveRecord::Base
  belongs_to :unit
  belongs_to :ship

  def check_conditions
    return ship.user.check_condition(self.unit.conditions) && ship.check_condition(self.unit.conditions)
  end

  def get_duration()
    factor = (1 + 0.1 * ship.ships_stations.find_by(:station_id => 2006).level) 
    return ((self.unit.get_total_cost / 500) * 120) / factor
  end

  def get_max_buy_amount()
    s = self.ship
    u = self.unit
    amounts = []

    if(u.get_metal_cost!=0)
      amounts << s.metal/u.get_metal_cost
    end
    if(u.get_crystal_cost!=0)
      amounts << s.cristal/u.get_crystal_cost
    end
    if(u.get_fuel_cost!=0)
      amounts << s.fuel/u.get_fuel_cost
    end
    
    return amounts.min.to_i
  end

   def get_ratio
    if self.start_time == nil
      return 1.0
    else
      duration = self.get_duration().to_f
      past = Time.now - self.start_time
      ratio = 1.0 - (past / duration)
      if(ratio >= 0.1)
        return ratio
      else
        return 0.0
      end
    end
  end

  def get_refund
    unit = self.unit
    amount = self.build_amount

    ratio = self.get_ratio
    reMetal = unit.get_metal_cost_ratio(ratio + amount - 1)
    reCrystal = unit.get_crystal_cost_ratio(ratio + amount - 1)
    reFuel = unit.get_fuel_cost_ratio(ratio + amount - 1)

    back = ""
    back = back + "Rückzahlung beim Abbruch [" + self.ship.name + "]: <br>"
    back = back + "- Metall: "+reMetal.to_i.to_s + "<br>"
    back = back + "- Kristalle: "+reCrystal.to_i.to_s + "<br>"
    back = back + "- Treibstoff: "+reFuel.to_i.to_s + "<br>"

    return back.html_safe
  end

  def get_conditions()
    info = self.unit.conditions
    conds = info.split(",")

    back = ""

    if(ship.capped_units)
      back = back + "Aktuell werden schon zu viele Anlagentypen gebaut...<br>"
    end;
    if (conds.length==0)
      return back.html_safe;
    end
    user = self.ship.user_ship.user;
    back = back + "Voraussetzung: <br>"
    conds.each do |cond|
      c_info = cond.split(":")
      typ = c_info[0]
      id_geb = c_info[1].to_i
      lvl = c_info[2]
      case typ
      when 'f'
        science = Science.find_by(:science_condition_id => id_geb)
        if not(user.has_min_science_level(science, lvl))
          back = back+"- Forschung: "+science.name+" "+lvl.to_s+"<br>"
        end
      when 'g'
        station = Station.find_by(:station_condition_id => id_geb)
        if not(self.ship.has_min_station_level(station, lvl))
          back = back+"- Gebäude: "+station.name+" "+lvl.to_s+"<br>"
        end
      else
      end
    end

    return back.html_safe
  end


  def reset_build
    update = true
    if self.start_time == nil
      update = false
    end
    self.start_time = nil
    self.build_amount = nil
    self.save
    b = BuildList.find_by(typeSign: 'u', instance_id: self.id)
    if b != nil
      b.destroy
    end
    if update
      ship.update_builds('u')
    end
  end

  
end