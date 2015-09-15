class BuildList < ActiveRecord::Base
	belongs_to :ship

after_create :startBuild

def startBuild
	case self.typeSign

	when 'f'
		if ship.build_list_count(self.typeSign) <= 1
			facility_instance = FacilityInstance.find_by(id: self.instance_id)
    		facility_instance.start_time = Time.now
			facility_instance.save	
		end
	when 'u'
		if ship.build_list_count(self.typeSign) <= 1
			unit_instance = UnitInstance.find_by(id: self.instance_id)
    		unit_instance.start_time = Time.now
			unit_instance.save	
		end
	when 'r'
		science_instance = ScienceInstance.find_by(id: self.instance_id)
		science_instance.research_ship = ship.id
    	science_instance.start_time = Time.now
		science_instance.save	
	when 's'
	end
end

def getDuration
	case self.typeSign
	when 'f'
		return getDurationF
	when 'u'
		return getDurationU
	when 'r'
		return getDurationR
	when 's'
		return getDurationS
	end
end

def getDurationF(instance = FacilityInstance.find_by(id: self.instance_id))
	return Facility.update_time(instance, false)
end

def getDurationS

end

def getDurationR(instance = ScienceInstance.find_by(id: self.instance_id))
	return Science.update_time(instance, false)
end

def getDurationU(instance = UnitInstance.find_by(id: self.instance_id))
	return Unit.update_time(instance, false)
end

end
