# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


DamageType.create({"name"=>"laser", "shell_mult"=>1.5,"shield_mult"=>1,"station_mult"=>1,"plattform_mult"=>1})
DamageType.create({"name"=>"ionen", "shell_mult"=>1,"shield_mult"=>1.5,"station_mult"=>1,"plattform_mult"=>1})
DamageType.create({"name"=>"bomb", "shell_mult"=>1,"shield_mult"=>1,"station_mult"=>10,"plattform_mult"=>1})
DamageType.create({"name"=>"teleport", "shell_mult"=>1,"shield_mult"=>1,"station_mult"=>1,"plattform_mult"=>1000})

Unit.create({"name"=>"Expeditionsschiff", "metal_price"=>40, "crystal_price"=>0, "fuel_price"=>10, "total_cost"=>80, "shell"=>50, "damage"=>2, "damage_type_id"=>1, "cargo"=>400, "speed"=>8, "shipyard_requirement"=>6, "research_requirement_one"=>4, "research_requirement_two"=>4})
Unit.create({"name"=>"Kleiner Transporter", "metal_price"=>5, "crystal_price"=>2, "fuel_price"=>0, "total_cost"=>9, "shell"=>2, "damage"=>0, "damage_type_id"=>nil, "cargo"=>80, "speed"=>4, "shipyard_requirement"=>4, "research_requirement_one"=>2, "research_requirement_two"=>0})
Unit.create({"name"=>"Großer Transporter", "metal_price"=>20, "crystal_price"=>8, "fuel_price"=>0, "total_cost"=>36, "shell"=>8, "damage"=>0, "damage_type_id"=>nil, "cargo"=>400, "speed"=>8, "shipyard_requirement"=>8, "research_requirement_one"=>8, "research_requirement_two"=>8})
Unit.create({"name"=>"Spionagedrohne", "metal_price"=>2, "crystal_price"=>0, "fuel_price"=>2, "total_cost"=>10, "shell"=>1, "damage"=>0, "damage_type_id"=>nil, "cargo"=>1, "speed"=>128, "shipyard_requirement"=>4, "research_requirement_one"=>2, "research_requirement_two"=>2})
Unit.create({"name"=>"Jäger", "metal_price"=>2, "crystal_price"=>1, "fuel_price"=>0, "total_cost"=>4, "shell"=>1, "damage"=>1, "damage_type_id"=>1, "cargo"=>2, "speed"=>8, "shipyard_requirement"=>2, "research_requirement_one"=>2, "research_requirement_two"=>2})
Unit.create({"name"=>"Fregatte", "metal_price"=>20, "crystal_price"=>10, "fuel_price"=>0, "total_cost"=>40, "shell"=>10, "damage"=>12, "damage_type_id"=>2, "cargo"=>5, "speed"=>8, "shipyard_requirement"=>4, "research_requirement_one"=>4, "research_requirement_two"=>12})
Unit.create({"name"=>"Kreuzer", "metal_price"=>20, "crystal_price"=>40, "fuel_price"=>0, "total_cost"=>100, "shell"=>10, "damage"=>50, "damage_type_id"=>2, "cargo"=>8, "speed"=>4, "shipyard_requirement"=>6, "research_requirement_one"=>6, "research_requirement_two"=>6})
Unit.create({"name"=>"Bomber", "metal_price"=>20, "crystal_price"=>0, "fuel_price"=>10, "total_cost"=>60, "shell"=>20, "damage"=>10, "damage_type_id"=>3, "cargo"=>5, "speed"=>8, "shipyard_requirement"=>8, "research_requirement_one"=>8, "research_requirement_two"=>6})
Unit.create({"name"=>"Zerstörer", "metal_price"=>200, "crystal_price"=>100, "fuel_price"=>0, "total_cost"=>400, "shell"=>200, "damage"=>500, "damage_type_id"=>3, "cargo"=>20, "speed"=>4, "shipyard_requirement"=>10, "research_requirement_one"=>10, "research_requirement_two"=>8})
Unit.create({"name"=>"Bombenteleporter", "metal_price"=>0, "crystal_price"=>250, "fuel_price"=>100, "total_cost"=>900, "shell"=>100, "damage"=>50, "damage_type_id"=>4, "cargo"=>100, "speed"=>1, "shipyard_requirement"=>12, "research_requirement_one"=>10, "research_requirement_two"=>12})
Unit.create({"name"=>"EMP-Schiff", "metal_price"=>0, "crystal_price"=>400, "fuel_price"=>100, "total_cost"=>1200, "shell"=>100, "damage"=>20, "damage_type_id"=>2, "cargo"=>120, "speed"=>1, "shipyard_requirement"=>10, "research_requirement_one"=>10, "research_requirement_two"=>12})
Unit.create({"name"=>"Mobiler Schild", "metal_price"=>0, "crystal_price"=>4, "fuel_price"=>1, "total_cost"=>12, "shell"=>5, "damage"=>0, "damage_type_id"=>nil, "cargo"=>2, "speed"=>4, "shipyard_requirement"=>10, "research_requirement_one"=>10, "research_requirement_two"=>10})
