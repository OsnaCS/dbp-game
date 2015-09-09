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
# Creator for table Stations
Station.create([
	{
	  id: 2001,
	  name: 'Kollektor Metall',
	  costMineral: 4,
	  costCristal: 1,
	  costFuel: 0,
	  initial_level: 0,
	  tier: 1,
	  icon: 'Metallscanner.png'
	},
	{
	  id: 2002,
	  name: 'Kollektor Kristall',
	  costMineral: 2,
	  costCristal: 2,
	  costFuel: 0,
	  initial_level: 0,
	  tier: 1,
	  icon: 'Kristallscanner.png'
	},
	{
	  id: 2003,
	  name: 'Kollektor Treibstoff',
	  costMineral: 2,
	  costCristal: 0,
	  costFuel: 1,
	  initial_level: 0,
	  tier: 1,
	  icon: 'Treibstoffscanner.png'
	},
	{
	  id: 2004,
	  name: 'Forschungsstation',
	  costMineral: 0,
	  costCristal: 2,
	  costFuel: 1,
	  initial_level: 0,
	  condition: 99,
	  tier: 2,
	  icon: 'Forschungsstation.png'
	},
	{
	  id: 2005,
	  name: 'Baugebäude',
	  costMineral: 2,
	  costCristal: 1,
	  costFuel: 0,
	  initial_level: 0,
	  tier: 1,
	  icon: 'Baugebaeude.png'
	},
	{
	  id: 2006,
	  name: 'Werft',
	  costMineral: 4,
	  costCristal: 0,
	  costFuel: 1,
	  initial_level: 0,
	  condition: 99,
	  tier: 2,
	  icon: 'Werft.png'
	},
	{
	  id: 2007,
	  name: 'Erweiterungsplattform',
	  costMineral: 8,
	  costCristal: 0,
	  costFuel: 2,
	  initial_level: 0,
	  condition: 99,
	  tier: 3,
	  icon: 'Erweiterungsplattform.png'
	},
	{
	  id: 2008,
	  name: 'Ressourcenlager Metall',
	  costMineral: 3,
	  costCristal: 1,
	  costFuel: 0,
	  initial_level: 0,
	  tier: 1,
	  icon: 'Metalllager.png'
	},
	{
      id: 2009,
      name: 'Ressourcenlager Kristall',
      costMineral: 1,
      costCristal: 2,
      costFuel: 0,
      initial_level: 0,
	  tier: 1,
	  icon: 'Kristalllager.png'
	},
	{
	  id: 2010,
	  name: 'Ressourcenlager Treibstoff',
	  costMineral: 1,
	  costCristal: 0,
	  costFuel: 1,
	  initial_level: 0,
	  tier: 1,
	  icon: 'Treibstofflager.png'
	},
	{
	  id: 2011,
	  name: 'Ressourcentresor Metall',
	  costMineral: 6,
	  costCristal: 2,
	  costFuel: 0,
	  initial_level: 0,
	  condition: 99, tier: 2,
	  icon: 'Metalltresor.png'
	},
	{
	  id: 2012,
	  name: 'Ressourcentresor Kristall',
	  costMineral: 2,
	  costCristal: 4,
	  costFuel: 0,
	  initial_level: 0,
	  condition: 99,
	  tier: 2,
	  icon: 'Kristalltresor.png'
	},
	{
	  id: 2013,
	  name: 'Ressourcentresor Treibstoff',
	  costMineral: 2,
	  costCristal: 0,
	  costFuel: 2,
	  initial_level: 0,
	  condition: 99,
	  tier: 2,
	  icon: 'Treibstofftresor.png'
	},
	{
	  id: 2014,
	  name: 'Energiegenerator',
      costMineral: 0,
      costCristal: 1,
      costFuel: 1,
      initial_level: 0,
	  tier: 1,
	  icon: 'Energiegenerator.png'
	},
	{
	  id: 2015,
	  name: 'Verbrennungsgenerator',
	  costMineral: 4,
	  costCristal: 0,
	  costFuel: 1,
	  initial_level: 0,
	  condition: 99,
	  tier: 2,
	  icon: 'Verbrennungsgenerator.png'
	},
	{
	  id: 2016,
	  name: 'Reparaturgebäude',
	  costMineral: 8,
	  costCristal: 4,
	  costFuel: 0,
	  initial_level: 0,
	  condition: 99,
	  tier: 3,
	  icon: 'Reparaturgebaeude.png'
    }
])
    
# Creator for Messages
Message.create([
	# Messages for Science
	{
	  mes: 'verstärkt Strukturierungen, verbessert die Hülle jeder Einheit um 10% pro Level',
	  code: 4001
	},
	{
	  mes: 'verbessert zusätzlich den Schaden der Laserwaffen um 10% pro Level, 50% effektiver gegen Hüllen',
      code: 4002
	},
	{
	  mes: 'verbessert erfolgreiche Spionage(-abwehr), Zusatzinformationen ab Level: 8,16',
	  code: 4003
	},
	{
	  mes: 'verringert die Reisekosten',
	  code: 4004
	},
	{
	  mes: 'verbessert den Schaden der Ionenkanonen um 10% pro Level, Ionen machen 50% mehr Schaden an Schilden',
	  code: 4005
	},
	{
	  mes: 'verbessert Schildgeneratoren um 10% pro Level',
	  code: 4006
	},
	{
	  mes: 'verringert die Missrate der Piloten',
	  code: 4007
	},
	{
	  mes: 'ermöglicht die Forschungzusammenarbeit mehrerer Mutterschiffe',
	  code: 4008
	},
	{
	  mes: 'gestattet ein zusätzliches Mutterschiff je Level',
	  code: 4009
	},
	{
	  mes: 'verbessert Kinetikwaffen um 10% pro Level, ausgeglichener Schaden',
	  code: 4010
	},

	# Messages for Units
	{
	  mes: 'dienen zur Spionage anderer Spieler',
	  code: 3001
	},
	{
	  mes: 'dienen zur Schildverteidigung der eigenen Flotte',
	  code: 3002
	},
	{
	  mes: 'dienen zur Ausschaltung gegnerischer Schilde, offensive Einheit, ionenbasierend',
	  code: 3003
	},
	{
	  mes: 'offensive Einheit, effektiv gegen orbitale Waffenplattform(1000facher Schaden)',
	  code: 3004
	},
	{
	  mes: 'dienen zum Transport von Ressourcen',
	  code: 3005
	},
	{
	  mes: 'dienen zum Transport von Ressourcen',
	  code: 3006
	},
	{
	  mes: 'dienen zur Erforschung des unbekannten Weltraumes',
	  code: 3007
	},
	{
	  mes: 'offensive Einheit, laserbasierend',
	  code: 3008
	},
	{
	  mes: 'offensive Einheit, laserbasierend',
	  code: 3009
	},
	{
	  mes: 'offensive Einheit, ionenbasierend',
	  code: 3010
	},
	{
	  mes: 'offensive Einheit, kinetikbasierend',
	  code:	3011
	},
	{
	  mes: 'offensive Einheit, effektiv gegen Anlagen(10facher Schaden), kinetikbasieren',
	  code:	3012
	},
	{
	  mes: 'dienen zur Energiegewinnung',
	  code:	3013
	},
	{
	  mes: 'Standardverteidigungseinheit, Raketenbasierend',
	  code:	3014
	},
	{
	  mes: 'defensive Einheit, laserbasierend',
	  code:	3015
	},
	{
	  mes: 'defensive Einheit, laserbasierend',
	  code:	3016
	},
	{
	  mes: 'defensive Einheit, ionenbasierend',
	  code:	3017
	},
	{
	  mes: 'defensive Einheit, ionenbasierend',
	  code:	3018
	},
	{
	  mes: 'defensive Einheit, kinetikbasierend',
	  code:	3019
	},
	{
	  mes:'defensive Einheit, kinetikbasierend',
	  code:	3020
	},
	{
	  mes: '???',
	  code:	3021
	},
	{
	  mes: 'dienen zur Schildverteidigung des Mutterschiffes',
	  code:	3022
	},
	{
	  mes: 'dienen zur Schildverteidigung des Mutterschiffes',
	  code:	3023
	},

	# Messages for Stations
	{
	  mes: 'dient zur kontinuierlichen Metallgewinnung',
	  code: 2001
	},
	{
	  mes: 'dient zur kontinuierlichen Kristallgewinnung',
	  code: 2002
	},
	{
	  mes: 'dient zur kontinuierlichen Treibstoffgewinnung',
	  code: 2003
	},
	{
	  mes: 'dient zur Erforschung neuer Technologien',
	  code: 2004
	},
	{
	  mes: 'baut Gebäude',
	  code: 2005
	},
	{
	  mes: 'baut defensive und offensive Einheiten',
	  code: 2006
	},
	{
	  mes: 'erweitert die Grundfläche des Mutterschiffes',
	  code: 2007
	},
	{
	  mes: 'lagert Metall',
	  code: 2008
	},
	{
	  mes: 'lagert Kristal',
	  code: 2009
	},
	{
	  mes: 'lagert Treibstoff',
	  code: 2010
	},
	{
	  mes: 'sicheres Metalllager',
	  code: 2011
	},
	{
	  mes: 'sicheres Kristalllager',
	  code: 2012
	},
	{
	  mes: 'sicheres Treibstofflager',
	  code: 2013
	},
	{
	  mes: 'erzeugt Energie',
	  code: 2014
	},
	{
	  mes: 'verbraucht Treibstoff zur Energiegewinnung',
	  code: 2015
	},
	{
	  mes: 'repariert defensive Einheiten',
	  code: 2016
	},

	# Messages for Event: nothing
	{
	  mes: 'Deine Einheiten haben nur die Weite des Weltraumes gesehen und kamen zurück.',
	  code: 5001
	},
	{
	  mes: 'Deine Einheiten haben ein Dokument gefunden,
	  	    allerdings ist es mit Milch durchweicht wodurch es unleserlich wurde.',
	  code: 5002
	},
	{
	  mes: 'Deine Einheiten haben einen kleinen Stop bei SpaceBurger gemacht und kamen gesättigt zurück.',
	  code: 5003
	},
	{
	  mes: 'Deine Einheiten bewunderten einige exotische Planeten.',
	  code: 5004
	},
	{
	  mes: 'Deine Einheiten haben einige friedliche Schiffe entdeckt und kamen unversehrt zurück.',
	  code: 5005
	},
	{
	  mes: 'Deine Einheiten haben einen Kaffe getrunken im Restaurant am Ende des Universiums.',
	  code: 5006
	},

	# Messages for Event: combat
	{
	  mes: 'Auf seiner Reise fiel deine Expedition in die Hände berüchtigter Weltraumpiraten.',
	  code: 5101
	},
	{
	  mes: 'Deine Einheiten landeten auf ihrer Reise im Orbit eines unbekannten Planeten,
	        auf dem sie Eingeborene trafen. Aufgrund eines kulturellen Missverständnisses
	        kam es zu einer Schlacht zwischen den Parteien.',
	  code: 5102
	},
	{
	  mes: 'Deine Einheiten trafen auf ein Volk, dass aufgrund eines traumatischen Erlebnisses darüber erzürnt war,
	        dass die Crew Milch bei sich hatte. Es kam zur Schlacht.',
	  code: 5103
	},
	{
	  mes: 'Deine Einheiten trafen auf eine Crew eines verfeindeten Mutterschiffes. Es kam zur Auseinandersetzung.',
	  code: 5104
	},
	{
	  mes: 'Deine Einheiten kamen in eine intergalaktische Bar und haben sich unfreiwillig mit einer
	        Weltraum-Motorrad-Gang angelegt.',
	  code: 5105
	},
	{
	  mes: 'Der Expeditionstrupp wurde von einem gigantischen grünlich leuchtenden Würfel angegriffen.',
	  code: 5106
	},

	# Messages for Event: destruction
	{
	  mes: 'Keine deiner Einheiten kamen zurück, es wurden lediglich Trümmer gefunden.',
	  code: 5201
	},
	{
	  mes: 'Deine Einheiten haben einen katastrophalen Unfall gehabt ... vielleicht Wildwechsel?',
	  code: 5202
	},
	{
	  mes: 'Deine Einheiten haben einen Verkehrsunfall gehabt. Ihnen wurde die Vorfahrt genommen ...
	        wobei jeder weiß, dass man Vorfahrt hat, wenn man nett lächelt und winkt.',
	  code: 5203
	},
	{
	  mes: 'Deine Einheiten haben bekanntschaft mit einem Asteroiden gemacht ... von nahem.',
	  code: 5204
	},
	{
	  mes: 'Deine Einheiten wurden von einem SpaceShark gefressen,
	        leider hört man im luftleeren Raum das JawsTheme nicht.',
	  code: 5205
	},
	{
	  mes: 'Deine Einheiten wurden ausgebeutet und ohne Treibstoff zurück gelassen ...
	        dabei hatten diese nichtmal eine Freibeuterlizenz dabei.',
	  code: 5206
	},
	{
	  mes: 'Deine Einheiten flogen in ein schwarzes Loch.',
	  code: 5207
	},
	{
	  mes: 'Es gibt keine Informationen über deine Einheiten.',
	  code: 5208
	},
	{
	  mes: 'Deine Einheiten verloren ihr Leben bei einem Trip per Anhalter durch die Galaxis.',
	  code: 5209
	},
	{
	  mes: 'Deine Einheiten kamen ums Leben, du hast Ihnen kein Handtuch mitgegeben.',
	  code: 5210
	},
	{
	  mes: 'Das rote T-Shirt brachte wohl kein Glück.',
	  code: 5211
	},

	# Messages for Event: salvage
	{
	  mes: 'Deine Einheiten fanden eine verlassene Zivilisation. Sie nahmen Schiffe und goldene Tierstatuen mit.',
	  code: 5301
	},
	{
	  mes: 'Deine Einheiten nahmen an einer intergalaktischen Auktion teil und haben ein paar Schiffe ersteigert.
	        Zum Glück waren Steine die örtliche Währung.',
	  code: 5302
	},
	{
	  mes: 'Deine Einheiten fanden ein verlassenes Mutterschiff. Sie nahmen die brauchbaren Schiffe mit.',
	  code: 5303
	},
	{
	  mes: 'Deine Einheiten schlossen sich einem Krieg gegen einen Imperator an und gewannen.
	        Aus Dankbarkeit erhielten sie Schiffe.',
	  code: 5304
	},
	{
	  mes: 'Deine Einheiten fanden ein verlassenes Schiffslager und plünderten es.',
	  code: 5305
	},
	{
	  mes: 'Deine Einheiten haben aus Langeweile aus den geborgenen Ressourcen neue Schiffe erbaut.',
	  code: 5306
	},
	{
	  mes: 'Deine Truppen haben ihren Unwahrscheinlichkeitsdrive benutzt. Sie kamen in der Nähe eines Planeten aus,
	        welcher sich urplötzlich in unbesetzte Schiffe umwandelte.',
	  code: 5307
	},

	# Messages for Event: ressources
	{
	  mes: 'Deine Einheiten durchkämmten die Wüste (mit einem Kamm) und fanden dabei einige lohnende Ressourcen.',
	  code: 5401
	},
	{
	  mes: 'Deine Einheiten fanden einen unbewohnten Planten mit vielen Ressourcen.',
	  code: 5402
	},
	{
	  mes: 'Deine Einheiten flogen mit Gold los, um neue Güter zu ertauschen, und erhielten zuerst Pferde,
	        welche sie dann weiter eintauschten, Schweine erhielten sie aber nicht.',
	  code: 5403
	},
	{
	  mes: 'Deine Einheiten kamen an einem intergalaktischen Kirmes vorbei und gewannen bei dem Spiel
	        "Wirf die Ringe um den Saturn einige wertvolle Ressourcen."',
	  code: 5404
	},
	{
	  mes: 'Deine Einheiten trafen auf ein Transportschiff und beuteten dieses aus ...
	        sie fühlten sich dabei schlecht, da sie ihre Freibeuterlizenz nicht dabei hatten.',
	  code: 5405
	},
	{
	  mes: 'Deine Einheiten haben einen seltsamen großen Würfel gefunden, der plötzlich klein wurde.
	        Sie nahmen diesen Würfel und verkauften ihn an eine mechanoide Rasse.',
	  code: 5406
	}
])
