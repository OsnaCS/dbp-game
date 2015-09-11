# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Facility.create([
	{
		id: 3013,
		cost1: 0,
		cost2: 2,
		cost3: 1,
		duration: 120 * 8,
		condition: 'g:6:2,f:1:2',
		name: 'Solarpanel',
		facility_condition_id: 13,
		icon: 'solar.png'
	},
	{
		id: 3014,
		cost1: 2,
		cost2: 0,
		cost3: 0,
		duration: 120 * 2,
		condition: 'g:6:2',
		name: 'Raketenturm',
		facility_condition_id: 14,
		icon: 'rocket.png'
	},
	{
		id: 3015,
		cost1: 3,
		cost2: 1,
		cost3: 0,
		duration: 120 * 5,
		condition: 'g:6:4,f:2:4',
		name: 'Kleines Lasergeschütz',
		facility_condition_id: 15,
		icon: 'laser_small.png'
	},
	{
		id: 3016,
		cost1: 12,
		cost2: 4,
		cost3: 0,
		duration: 120 * 20,
		condition: 'g:6:8,f:2:8',
		name: 'Großes Lasergeschütz',
		facility_condition_id: 16,
		icon: 'laser_big.png'
	},
	{
		id: 3017,
		cost1: 2,
		cost2: 3,
		cost3: 0,
		duration: 120 * 8,
		condition: 'g:6:6,f:5:4',
		name: 'Kleiner Ionenbeschleuniger',
		facility_condition_id: 17,
		icon: 'ion_small.png'
	},
	{
		id: 3018,
		cost1: 8,
		cost2: 12,
		cost3: 0,
		duration: 120 * 32,
		condition: 'g:6:8,f:5:8',
		name: 'Großer Ionenbeschleuniger',
		facility_condition_id: 18,
		icon: 'ion_big.png'
	},
	{
		id: 3019,
		cost1: 80,
		cost2: 20,
		cost3: 0,
		duration: 120 * 120,
		condition: 'g:6:10,f:8:4',
		name: 'Massenbeschleuniger',
		facility_condition_id: 19,
		icon: 'mac.png'
	},
	{
		id: 3020,
		cost1: 1000,
		cost2: 0,
		cost3: 200,
		duration: 120 * 1800,
		condition: 'g:6:12,f:8:10',
		name: 'Orbitale Waffenplattform',
		facility_condition_id: 20,
		icon: 'orbital.png'
	},
	{
		id: 3021,
		cost1: 0,
		cost2: 500,
		cost3: 1000,
		duration: 120 * 5000,
		condition: 'g:6:16,f:9:6,f:10:8',
		name: 'Kuhtapult',
		facility_condition_id: 21,
		icon: 'udder.png'
	},
	{
		id: 3022,
		cost1: 50,
		cost2: 100,
		cost3: 0,
		duration: 120 * 250,
		condition: 'g:6:6,f:6:2',
		name: 'Kleiner Schild',
		facility_condition_id: 22,
		icon: 'shield_small.png'
	},
	{
		id: 3023,
		cost1: 200,
		cost2: 400,
		cost3: 0,
		duration: 120 * 1000,
		condition: 'g:6:8,f:6:6',
		name: 'Großer Schild',
		facility_condition_id: 23,
		icon: 'shield_big.png'
	}])

Science.create([
	{
		id: 4001,
		cost1: 10,
		cost2: 0,
		cost3: 0,
		factor: 2,
		duration: 60,
		condition: '',
		name: 'Hülle',
		tier: 1,
		science_condition_id: 1,
		icon: 'huelle.png',
		level_cap: nil
	},
	{
		id: 4002,
		cost1: 4,
		cost2: 3,
		cost3: 0,
		factor: 2,
		duration: 60,
		condition: '',
		name: 'Laser',
		tier: 1,
		science_condition_id: 2,
		icon: 'laser.png',
		level_cap: nil
	},
	{
		id: 4003,
		cost1: 0,
		cost2: 3,
		cost3: 1,
		factor: 2,
		duration: 60,
		condition: '',
		name: 'Spionage',
		tier: 1,
		science_condition_id: 3,
		icon: 'spionage.png',
		level_cap: nil
	},
	{
		id: 4004,
		cost1: 8,
		cost2: 0,
		cost3: 3,
		factor: 2,
		duration: 120,
		condition: 'f:1:4',
		name: 'Triebwerke',
		tier: 2,
		science_condition_id: 4,
		icon: 'triebwerke.png',
		level_cap: nil
	},
	{
		id: 4005,
		cost1: 4,
		cost2: 8,
		cost3: 0,
		factor: 2,
		duration: 120,
		condition: 'f:2:10',
		name: 'Ionen',
		tier: 2,
		science_condition_id: 5,
		icon: 'ionen.png',
		level_cap: nil
	},
	{
		id: 4006,
		cost1: 0,
		cost2: 6,
		cost3: 2,
		factor: 2,
		duration: 120,
		condition: 'f:1:10,f:5:2',
		name: 'Schild',
		tier: 2,
		science_condition_id: 6,
		icon: 'schilde.png',
		level_cap: nil
	},
	{
		id: 4007,
		cost1: 20,
		cost2: 0,
		cost3: 5,
		factor: 2,
		duration: 240,
		condition: 'f:4:4',
		name: 'Pilotentraining',
		tier: 3,
		science_condition_id: 7,
		icon: 'pilotentraining.png',
		level_cap: 20
	},
	{
		id: 4008,
		cost1: 0,
		cost2: 160,
		cost3: 100,
		factor: 2,
		duration: 43200,
		condition: 'f:3:12',
		name: 'Netzwerk',
		tier: 4,
		science_condition_id: 10,
		icon: 'netzwerk.png',
		level_cap: 8
	},
	{
		id: 4009,
		cost1: 320,
		cost2: 0,
		cost3: 100,
		factor: 2,
		duration: 43200,
		condition: 'f:7:8',
		name: 'Pioniersausbildung',
		tier: 4,
		science_condition_id: 9,
		icon: 'pioniersausbildung.png',
		level_cap: 6
	},
	{
		id: 4010,
		cost1: 20,
		cost2: 10,
		cost3: 0,
		factor: 2,
		duration: 240,
		condition: 'f:5:10',
		name: 'Kinetik',
		tier: 3,
		science_condition_id: 8,
		icon: 'kinetik.png',
		level_cap: nil
	}])

#Creator for table Trades
Trade.create([
	{
		id: 201,
		ressource: 1
	},
	{
		id: 202,
		ressource: 2
	},
	{
		id: 203,
		ressource: 4
	}
])

# Creator for table Stations
Station.create([
	{
	  id: 2001,
	  name: 'Kollektor Metall',
	  costMineral: 4,
	  costCristal: 1,
	  costFuel: 0,
	  initial_level: 0,
	  station_condition_id: 1,
	  condition: '',
	  tier: 1,
	  icon: 'metal-scanner.png',
	  duration: 120
	},
	{
	  id: 2002,
	  name: 'Kollektor Kristall',
	  costMineral: 2,
	  costCristal: 2,
	  costFuel: 0,
	  initial_level: 0,
	  station_condition_id: 2,
	  condition: '',
	  tier: 1,
	  icon: 'crystal-scanner.png',
	  duration: 120
	},
	{
	  id: 2003,
	  name: 'Kollektor Treibstoff',
	  costMineral: 2,
	  costCristal: 0,
	  costFuel: 1,
	  initial_level: 0,
	  station_condition_id: 3,
	  condition: '',
	  tier: 1,
	  icon: 'fuelscanner.png',
	  duration: 120
	},
	{
	  id: 2004,
	  name: 'Forschungsstation',
	  costMineral: 0,
	  costCristal: 2,
	  costFuel: 1,
	  initial_level: 0,
	  station_condition_id: 4,
	  condition: 's:5:4',
	  tier: 2,
	  icon: 'research-building.png',
	  duration: 240
	},
	{
	  id: 2005,
	  name: 'Baugebäude',
	  costMineral: 2,
	  costCristal: 1,
	  costFuel: 0,
	  initial_level: 0,
	  station_condition_id: 5,
	  condition: '',
	  tier: 1,
	  icon: 'construction-buildings.png',
	  duration: 120
	},
	{
	  id: 2006,
	  name: 'Werft',
	  costMineral: 4,
	  costCristal: 0,
	  costFuel: 1,
	  initial_level: 0,
	  station_condition_id: 6,
	  condition: 's:5:2',
	  tier: 2,
	  icon: 'dockyard.png',
	  duration: 240
	},
	{
	  id: 2007,
	  name: 'Erweiterungsplattform',
	  costMineral: 8,
	  costCristal: 0,
	  costFuel: 2,
	  initial_level: 0,
	  station_condition_id: 7,
	  condition: 's:5:10',
	  tier: 3,
	  icon: 'extension-platform.png',
	  duration: 480
	},
	{
	  id: 2008,
	  name: 'Ressourcenlager Metall',
	  costMineral: 3,
	  costCristal: 1,
	  costFuel: 0,
	  initial_level: 0,
	  station_condition_id: 8,
	  condition: '',
	  tier: 1,
	  icon: 'metal-stock.png',
	  duration: 120
	},
	{
      id: 2009,
      name: 'Ressourcenlager Kristall',
      costMineral: 1,
      costCristal: 2,
      costFuel: 0,
      initial_level: 0,
      station_condition_id: 9,
      condition: '',
	  tier: 1,
	  icon: 'crystal-stock.png',
	  duration: 120
	},
	{
	  id: 2010,
	  name: 'Ressourcenlager Treibstoff',
	  costMineral: 1,
	  costCristal: 0,
	  costFuel: 1,
	  initial_level: 0,
	  station_condition_id: 10,
	  condition: '',
	  tier: 1,
	  icon: 'fuel-stock.png',
	  duration: 120
	},
	{
	  id: 2011,
	  name: 'Ressourcentresor Metall',
	  costMineral: 6,
	  costCristal: 2,
	  costFuel: 0,
	  initial_level: 0,
	  station_condition_id: 11,
	  condition: 's:8:4',
	  tier: 2,
	  icon: 'metal-safe.png',
	  duration: 240
	},
	{
	  id: 2012,
	  name: 'Ressourcentresor Kristall',
	  costMineral: 2,
	  costCristal: 4,
	  costFuel: 0,
	  initial_level: 0,
	  station_condition_id: 12,
	  condition: 's:9:4',
	  tier: 2,
	  icon: 'crystal-safe.png',
	  duration: 240
	},
	{
	  id: 2013,
	  name: 'Ressourcentresor Treibstoff',
	  costMineral: 2,
	  costCristal: 0,
	  costFuel: 2,
	  initial_level: 0,
	  station_condition_id: 13,
	  condition: 's:10:4',
	  tier: 2,
	  icon: 'fuel-safe.png',
	  duration: 240
	},
	{
	  id: 2014,
	  name: 'Energiegenerator',
      costMineral: 0,
      costCristal: 1,
      costFuel: 1,
      initial_level: 0,
      station_condition_id: 14,
      condition: '',
	  tier: 1,
	  icon: 'energy-generator.png',
	  duration: 120
	},
	{
	  id: 2015,
	  name: 'Verbrennungsgenerator',
	  costMineral: 4,
	  costCristal: 0,
	  costFuel: 1,
	  initial_level: 0,
	  station_condition_id: 15,
	  condition: 's:14:4',
	  tier: 2,
	  icon: 'burn-generator.png',
	  duration: 240
	},
	{
	  id: 2016,
	  name: 'Reparaturgebäude',
	  costMineral: 8,
	  costCristal: 4,
	  costFuel: 0,
	  initial_level: 0,
	  station_condition_id: 16,
	  condition: 's:5:8',
	  tier: 3,
	  icon: 'repair-building.png',
	  duration: 480
}])

# Creator for Messages
Message.create([
	# Messages for Science
	{
	  mes: 'Verstärkt Strukturierungen, verbessert die Hülle jeder Einheit um 10% pro Level',
	  code: 4001
	},
	{
	  mes: 'Verbessert zusätzlich den Schaden der Laserwaffen um 10% pro Level, 50% effektiver gegen Hüllen',
      code: 4002
	},
	{
	  mes: 'Verbessert erfolgreiche Spionage(-abwehr), Zusatzinformationen ab Level: 8,16',
	  code: 4003
	},
	{
	  mes: 'Verringert die Reisekosten',
	  code: 4004
	},
	{
	  mes: 'Verbessert den Schaden der Ionenkanonen um 10% pro Level, Ionen machen 50% mehr Schaden an Schilden',
	  code: 4005
	},
	{
	  mes: 'Verbessert Schildgeneratoren um 10% pro Level',
	  code: 4006
	},
	{
	  mes: 'Verringert die Missrate der Piloten',
	  code: 4007
	},
	{
	  mes: 'Ermöglicht die Forschungzusammenarbeit mehrerer Mutterschiffe',
	  code: 4008
	},
	{
	  mes: 'Gestattet ein zusätzliches Mutterschiff je Level',
	  code: 4009
	},
	{
	  mes: 'Verbessert Kinetikwaffen um 10% pro Level, ausgeglichener Schaden',
	  code: 4010
	},

	# Messages for Units
	{
	  mes: 'Dienen zur Spionage anderer Spieler',
	  code: 3001
	},
	{
	  mes: 'Dienen zur Schildverteidigung der eigenen Flotte',
	  code: 3002
	},
	{
	  mes: 'Dienen zur Ausschaltung gegnerischer Schilde, offensive Einheit, ionenbasierend',
	  code: 3003
	},
	{
	  mes: 'Offensive Einheit, effektiv gegen orbitale Waffenplattform(1000facher Schaden)',
	  code: 3004
	},
	{
	  mes: 'Dienen zum Transport von Ressourcen',
	  code: 3005
	},
	{
	  mes: 'Dienen zum Transport von Ressourcen',
	  code: 3006
	},
	{
	  mes: 'Dienen zur Erforschung des unbekannten Weltraumes',
	  code: 3007
	},
	{
	  mes: 'Offensive Einheit, laserbasierend',
	  code: 3008
	},
	{
	  mes: 'Offensive Einheit, laserbasierend',
	  code: 3009
	},
	{
	  mes: 'Offensive Einheit, ionenbasierend',
	  code: 3010
	},
	{
	  mes: 'Offensive Einheit, kinetikbasierend',
	  code:	3011
	},
	{
	  mes: 'Offensive Einheit, effektiv gegen Anlagen(10facher Schaden), kinetikbasieren',
	  code:	3012
	},
	{
	  mes: 'Dienen zur Energiegewinnung',
	  code:	3013
	},
	{
	  mes: 'Standardverteidigungseinheit, Raketenbasierend',
	  code:	3014
	},
	{
	  mes: 'Defensive Einheit, laserbasierend',
	  code:	3015
	},
	{
	  mes: 'Defensive Einheit, laserbasierend',
	  code:	3016
	},
	{
	  mes: 'Defensive Einheit, ionenbasierend',
	  code:	3017
	},
	{
	  mes: 'Defensive Einheit, ionenbasierend',
	  code:	3018
	},
	{
	  mes: 'Defensive Einheit, kinetikbasierend',
	  code:	3019
	},
	{
	  mes:'Defensive Einheit, kinetikbasierend',
	  code:	3020
	},
	{
	  mes: 'Muuuh!',
	  code:	3021
	},
	{
	  mes: 'Dienen zur Schildverteidigung des Mutterschiffes',
	  code:	3022
	},
	{
	  mes: 'Dienen zur Schildverteidigung des Mutterschiffes',
	  code:	3023
	},
	{
	  mes: '???',
	  code:	3024
	},


	# Messages for Stations
	{
	  mes: 'Dient zur kontinuierlichen Metallgewinnung',
	  code: 2001
	},
	{
	  mes: 'Dient zur kontinuierlichen Kristallgewinnung',
	  code: 2002
	},
	{
	  mes: 'Dient zur kontinuierlichen Treibstoffgewinnung',
	  code: 2003
	},
	{
	  mes: 'Dient zur Erforschung neuer Technologien',
	  code: 2004
	},
	{
	  mes: 'Baut Gebäude',
	  code: 2005
	},
	{
	  mes: 'Baut defensive und offensive Einheiten',
	  code: 2006
	},
	{
	  mes: 'Erweitert die Grundfläche des Mutterschiffes',
	  code: 2007
	},
	{
	  mes: 'Lagert Metall',
	  code: 2008
	},
	{
	  mes: 'Lagert Kristal',
	  code: 2009
	},
	{
	  mes: 'Lagert Treibstoff',
	  code: 2010
	},
	{
	  mes: 'Sicheres Metalllager',
	  code: 2011
	},
	{
	  mes: 'Sicheres Kristalllager',
	  code: 2012
	},
	{
	  mes: 'Sicheres Treibstofflager',
	  code: 2013
	},
	{
	  mes: 'Erzeugt Energie',
	  code: 2014
	},
	{
	  mes: 'Verbraucht Treibstoff zur Energiegewinnung',
	  code: 2015
	},
	{
	  mes: 'Repariert defensive Einheiten',
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

#Create DamageType and Units
DamageType.create({"name"=>"laser", "shell_mult"=>1.5,"shield_mult"=>1,"station_mult"=>1,"plattform_mult"=>1})
DamageType.create({"name"=>"ionen", "shell_mult"=>1,"shield_mult"=>1.5,"station_mult"=>1,"plattform_mult"=>1})
DamageType.create({"name"=>"bomb", "shell_mult"=>1,"shield_mult"=>1,"station_mult"=>10,"plattform_mult"=>1})
DamageType.create({"name"=>"teleport", "shell_mult"=>1,"shield_mult"=>1,"station_mult"=>1,"plattform_mult"=>1000})

message1=Message.find_by code: 3007
message2=Message.find_by code: 3005
message3=Message.find_by code: 3006
message4=Message.find_by code: 3001
message5=Message.find_by code: 3008
message6=Message.find_by code: 3009
message7=Message.find_by code: 3010
message8=Message.find_by code: 3011
message9=Message.find_by code: 3012
message10=Message.find_by code: 3004
message11=Message.find_by code: 3002
message12=Message.find_by code: 3003

Unit.create({"name"=>"Expeditionsschiff", "metal_price"=>40, "crystal_price"=>0, "fuel_price"=>10, "total_cost"=>80, "shell"=>50, "damage"=>2, "damage_type_id"=>1, "cargo"=>400, "speed"=>8, "shipyard_requirement"=>6, "research_requirement_one"=>4, "research_requirement_two"=>4, "message"=> message1})
Unit.create({"name"=>"Kleiner Transporter", "metal_price"=>5, "crystal_price"=>2, "fuel_price"=>0, "total_cost"=>9, "shell"=>2, "damage"=>0, "damage_type_id"=>nil, "cargo"=>80, "speed"=>4, "shipyard_requirement"=>4, "research_requirement_one"=>2, "research_requirement_two"=>0,"message"=>message2})
Unit.create({"name"=>"Großer Transporter", "metal_price"=>20, "crystal_price"=>8, "fuel_price"=>0, "total_cost"=>36, "shell"=>8, "damage"=>0, "damage_type_id"=>nil, "cargo"=>400, "speed"=>8, "shipyard_requirement"=>8, "research_requirement_one"=>8, "research_requirement_two"=>8, "message"=>message3})
Unit.create({"name"=>"Spionagedrohne", "metal_price"=>2, "crystal_price"=>0, "fuel_price"=>2, "total_cost"=>10, "shell"=>1, "damage"=>0, "damage_type_id"=>nil, "cargo"=>1, "speed"=>128, "shipyard_requirement"=>4, "research_requirement_one"=>2, "research_requirement_two"=>2,"message"=>message4})
Unit.create({"name"=>"Jäger", "metal_price"=>2, "crystal_price"=>1, "fuel_price"=>0, "total_cost"=>4, "shell"=>1, "damage"=>1, "damage_type_id"=>1, "cargo"=>2, "speed"=>8, "shipyard_requirement"=>2, "research_requirement_one"=>2, "research_requirement_two"=>2, "message"=>message5})
Unit.create({"name"=>"Fregatte", "metal_price"=>20, "crystal_price"=>10, "fuel_price"=>0, "total_cost"=>40, "shell"=>10, "damage"=>12, "damage_type_id"=>2, "cargo"=>5, "speed"=>8, "shipyard_requirement"=>4, "research_requirement_one"=>4, "research_requirement_two"=>12,"message"=>message6})
Unit.create({"name"=>"Kreuzer", "metal_price"=>20, "crystal_price"=>40, "fuel_price"=>0, "total_cost"=>100, "shell"=>10, "damage"=>50, "damage_type_id"=>2, "cargo"=>8, "speed"=>4, "shipyard_requirement"=>6, "research_requirement_one"=>6, "research_requirement_two"=>6,"message"=>message7})
Unit.create({"name"=>"Bomber", "metal_price"=>20, "crystal_price"=>0, "fuel_price"=>10, "total_cost"=>60, "shell"=>20, "damage"=>10, "damage_type_id"=>3, "cargo"=>5, "speed"=>8, "shipyard_requirement"=>8, "research_requirement_one"=>8, "research_requirement_two"=>6,"message"=>message8})
Unit.create({"name"=>"Zerstörer", "metal_price"=>200, "crystal_price"=>100, "fuel_price"=>0, "total_cost"=>400, "shell"=>200, "damage"=>500, "damage_type_id"=>3, "cargo"=>20, "speed"=>4, "shipyard_requirement"=>10, "research_requirement_one"=>10, "research_requirement_two"=>8,"message"=>message9})
Unit.create({"name"=>"Bombenteleporter", "metal_price"=>0, "crystal_price"=>250, "fuel_price"=>100, "total_cost"=>900, "shell"=>100, "damage"=>50, "damage_type_id"=>4, "cargo"=>100, "speed"=>1, "shipyard_requirement"=>12, "research_requirement_one"=>10, "research_requirement_two"=>12,"message"=>message10})
Unit.create({"name"=>"EMP-Schiff", "metal_price"=>0, "crystal_price"=>400, "fuel_price"=>100, "total_cost"=>1200, "shell"=>100, "damage"=>20, "damage_type_id"=>2, "cargo"=>120, "speed"=>1, "shipyard_requirement"=>10, "research_requirement_one"=>10, "research_requirement_two"=>12,"message"=>message11})
Unit.create({"name"=>"Mobiler Schild", "metal_price"=>0, "crystal_price"=>4, "fuel_price"=>1, "total_cost"=>12, "shell"=>5, "damage"=>0, "damage_type_id"=>nil, "cargo"=>2, "speed"=>4, "shipyard_requirement"=>10, "research_requirement_one"=>10, "research_requirement_two"=>10,"message"=>message12})
