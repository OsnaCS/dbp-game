class BuildList < ActiveRecord::Base
	belongs_to :ship

after_create :startBuild

def startBuild
	if(self.typeSign == 'f')
		if ship.build_list_count(self.typeSign) <= 1
			facility_instance = FacilityInstance.find_by(id: self.instance_id)
    		facility_instance.start_time = Time.now
			facility_instance.save	
		end
	end
end

def getDurationF(instance = FacilityInstance.find_by(id: self.instance_id))
	return Facility.update_time(instance, false)
end

def getDurationS

end

def getDurationR

end

def getDurationU

end

end
