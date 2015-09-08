class ScienceInstance < ActiveRecord::Base
  belongs_to :science
  belongs_to :user

  def get_conditions()
  	info = self.science.condition
  	conds = info.split(",")

    back = ""
  	if(user.is_researching())
      back = back + "Aktuell wird geforscht...<br>"
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