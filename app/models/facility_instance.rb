class FacilityInstance < ActiveRecord::Base
  belongs_to :facility
  belongs_to :ship

  def get_conditions()
  	info = self.facility.condition
  	conds = info.split(",")

    back = ""
  	if(ship.is_building())
      back = back + "Aktuell wird gebaut...<br>"
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
  		name = Science.find_by(:science_condition_id => id_geb).name
  		back = back+"- Forschung: "+name+" "+lvl.to_s+"<br>"
  	end

  	return back.html_safe
  end





end
