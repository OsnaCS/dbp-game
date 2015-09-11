class FacilityInstance < ActiveRecord::Base
  belongs_to :facility
  belongs_to :ship

  def check_conditions
    return ship.user.check_condition(self.facility.condition) && ship.check_condition(self.facility.condition)
  end

  def is_hidden
    if self.facility.facility_condition_id == 21
      return !self.check_conditions
    end
    return false
  end

  def get_buy_amount()
    s = Ship.find_by(:id => self.ship_id)
    resourcenfactor = 500
    amount1 = amount2 = amount3 = nil
    if self.facility.cost1 != 0
      amount1 = s.metal / (self.facility.cost1 * resourcenfactor)
    end
    if self.facility.cost2 != 0
      amount2 = s.cristal / (self.facility.cost2 * resourcenfactor)
    end
    if self.facility.cost3 != 0
      amount3 = s.fuel / (self.facility.cost3 * resourcenfactor)
    end
    amount = 0
    if amount1 != nil
      amount = amount1
    end
    if amount2 != nil && (amount1 == nil || amount1 > amount2)
      amount = amount2
    end
    if amount3 != nil && (amount1 == nil && amount2 == nil || amount2 != nil && amount2 > amount3 || amount1 != nil && amount1 > amount3)
      amount = amount3
    end
    return amount
  end

  def get_conditions()
  	info = self.facility.condition
  	conds = info.split(",")

    back = ""
  	if(ship.building_capped())
      back = back + "Aktuell werden schon " + ship.is_building().to_s + " Anlagentypen gebaut...<br>"
  	end;
  	if (conds.length==0) 
  	  return back.html_safe;
  	end
  	back = back + "Voraussetzung: <br>"
  	conds.each do |cond|
  		c_info = cond.split(":")
  		typ = c_info[0]
  		id_geb = c_info[1].to_i
  		lvl = c_info[2]
      if(typ == 'f')
  		  name = Science.find_by(:science_condition_id => id_geb).name
  		  back = back+"- Forschung: "+name+" "+lvl.to_s+"<br>"
      end
      if(typ == 'g')
        name = Station.find_by(:id => 2000 + id_geb).name
        back = back+"- Station: "+name+" "+lvl.to_s+"<br>"
      end
  	end

  	return back.html_safe
  end





end
