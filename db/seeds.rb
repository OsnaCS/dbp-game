# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Creator for table Stations
Station.create([
	{
	  id: 2001,
	  name: 'Kollektor Metall',
	  costMineral: 4,
	  costCristal: 1,
	  costFuel: 0,
	  initial_level: 0,
	  #description: 'dient zur kontinuierlichen Metallgewinnung',
	  tier: '1',
	  icon: 'Metallscanner.png'
	},
	{
	  id: 2002,
	  name: 'Kollektor Kristall',
	  costMineral: 2,
	  costCristal: 2,
	  costFuel: 0,
	  initial_level: 0,
	  #description: 'dient zur kontinuierlichen Kristallgewinnung',
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
	  #description: 'dient zur kontinuierlichen Treibstoffgewinnung',
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
	  #description: 'dient zur Erforschung neuer Technologien',
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
	  #description: 'baut Gebäude',
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
	  #description: 'baut defensive und offensive Einheiten',
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
	  #description: 'erweitert die Grundfläche des Mutterschiffes',
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
	  #description: 'lagert Metall',
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
	  #description: 'lagert Kristall',
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
	  #description: 'lagert Treibstoff',
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
	  #description: 'sicheres Metalllager',
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
	  #description: 'sicheres Kristalllager',
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
	  #description: 'sicheres Treibstofflager',
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
	  #description: 'erzeugt Energie',
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
	  #description: 'verbraucht Treibstoff zur Energiegewinnung',
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
	  #description: 'repariert defensive Einheiten',
	  condition: 99,
	  tier: 3,
	  icon: 'Reparaturgebaeude.png'
	}
])
