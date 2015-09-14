class ShipsStation < ActiveRecord::Base

  belongs_to :ship
  belongs_to :station

  def get_time_since_upgrade
    return (Time.now - self.updated_at).to_i
  end

  def get_upgrade_ratio
    duration = self.station.get_duration(self.level).to_f
    past = self.get_time_since_upgrade.to_f
    return 1.0 - (past/duration).to_f
  end

  def get_refund
    station = self.station
    currentLevel = self.level

    ratio = self.get_upgrade_ratio
    reMetal = station.get_metal_cost_ratio(currentLevel, ratio)
    reCrystal = station.get_crystal_cost_ratio(currentLevel, ratio)
    reFuel = station.get_fuel_cost_ratio(currentLevel, ratio)

    back = ""
    back = back + "Refund: <br>"
    back = back+"- Metal: "+reMetal.to_i.to_s+"<br>"
    back = back+"- Crystal: "+reCrystal.to_i.to_s+"<br>"
    back = back+"- Fuel: "+reFuel.to_i.to_s+"<br>"

    return back.html_safe
  end

  def sum_level(ship)
    sum=0
    ShipsStation.where(:ship_id => ship.id).each do |station|
      sum+=station.level
    end  
    return sum - ShipsStation.find_by(ship_id: ship.id, station_id: 2007).level
  end

  def max_station_level(ship)
    i = 100 + 10 * ShipsStation.find_by(ship_id: ship.id, station_id: 2007).level
    return i
  end

  def get_conditions()
  	info = self.station.condition
  	conds = info.split(",")

    back = ""
  	if(ship.is_upgrading())
      back = back + "Aktuell wird eine Station ausgebaut ...<br>"
  	end
  	back = back + "Voraussetzung: <br>"
  	conds.each do |cond|
  		c_info = cond.split(":")
  		typ = c_info[0]
  		id_geb = c_info[1].to_i
  		lvl = c_info[2]
  		name = Station.find_by(:station_condition_id => id_geb).name
  		back = back+"- Station: "+name+" "+lvl.to_s+"<br>"
  	end

    leftMetal = station.get_metal_cost(self.level) - ship.metal
    leftCrystal = station.get_crystal_cost(self.level) - ship.cristal
    leftFuel = station.get_fuel_cost(self.level) - ship.fuel



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

  def update_time(format)
    station = Station.find_by(id: self.station_id)
    durationInSeconds = station.get_duration(self.level)

    if(self.start_time)
      timeSinceUpgrade = self.get_time_since_upgrade
      restTime = durationInSeconds - timeSinceUpgrade

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
