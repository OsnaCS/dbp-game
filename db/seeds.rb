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
	  name: 'Scanner Metall',
	  costMineral: 4,
	  costCristal: 1,
	  costFuel: 0,
	  initial_level: 0,
	  description: 'dient zur kontinuierlichen Metallgewinnung',
	  tier: '1',
	  icon: 'Metallscanner.png'
	},
	{
	  name: 'Scanner Kristall',
	  costMineral: 2,
	  costCristal: 2,
	  costFuel: 0,
	  initial_level: 0,
	  description: 'dient zur kontinuierlichen Kristallgewinnung',
	  tier: 1,
	  icon: 'Kristallscanner.png'
	},
	{
	  name: 'Scanner Treibstoff',
	  costMineral: 2,
	  costCristal: 0,
	  costFuel: 1,
	  initial_level: 0,
	  description: 'dient zur kontinuierlichen Treibstoffgewinnung',
	  tier: 1,
	  icon: 'Treibstoffscanner.png'
	},
	{
	  name: 'Energiegenerator',
      costMineral: 0,
      costCristal: 1,
      costFuel: 1,
      initial_level: 0,
	  description: 'erzeugt Energie',
	  tier: 1,
	  icon: 'Energiegenerator.png'
	},
	{
	  name: 'Verbrennungsgenerator',
	  costMineral: 4,
	  costCristal: 0,
	  costFuel: 1,
	  initial_level: 0,
	  description: 'verbraucht Treibstoff zur Energiegewinnung',
	  condition: 99,
	  tier: 2,
	  icon: 'Verbrennungsgenerator.png'
	},
	{
	  name: 'Baugebäude',
	  costMineral: 2,
	  costCristal: 1,
	  costFuel: 0,
	  initial_level: 0,
	  description: 'baut Gebäude',
	  tier: 1,
	  icon: 'Baugebaeude.png'
	},
	{
	  name: 'Werf',
	  costMineral: 4,
	  costCristal: 0,
	  costFuel: 1,
	  initial_level: 0,
	  description: 'baut defensive und offensive Einheiten',
	  condition: 99,
	  tier: 2,
	  icon: 'Werft.png'
	},
	{
	  name: 'Forschungsstation',
	  costMineral: 0,
	  costCristal: 2,
	  costFuel: 1,
	  initial_level: 0,
	  description: 'dient zur Erforschung neuer Technologien',
	  condition: 99,
	  tier: 2,
	  icon: 'Forschungsstation.png'
	},
	{
	  name: 'Erweiterungsplattform',
	  costMineral: 8,
	  costCristal: 0,
	  costFuel: 2,
	  initial_level: 0,
	  description: 'erweitert die Grundfläche des Mutterschiffes',
	  condition: 99,
	  tier: 3,
	  icon: 'Erweiterungsplattform.png'
	},
	{
	  name: 'Reparaturgebäude',
	  costMineral: 8,
	  costCristal: 4,
	  costFuel: 0,
	  initial_level: 0,
	  description: 'repariert defensive Einheiten',
	  condition: 99,
	  tier: 3,
	  icon: 'Reparaturgebaeude.png'
	},
	{
	  name: 'Ressourcenlager Metall',
	  costMineral: 3,
	  costCristal: 1,
	  costFuel: 0,
	  initial_level: 0,
	  description: 'lagert Metall',
	  tier: 1,
	  icon: 'Metalllager.png'
	},
	{
      name: 'Ressourcenlager Kristall',
      costMineral: 1,
      costCristal: 2,
      costFuel: 0,
      initial_level: 0,
	  description: 'lagert Kristall',
	  tier: 1,
	  icon: 'Kristalllager.png'
	},
	{
	  name: 'Ressourcenlager Treibstoff',
	  costMineral: 1,
	  costCristal: 0,
	  costFuel: 1,
	  initial_level: 0,
	  description: 'lagert Treibstoff',
	  tier: 1,
	  icon: 'Treibstofflager.png'
	},
	{
	  name: 'Ressourcentresor Metall',
	  costMineral: 6,
	  costCristal: 2,
	  costFuel: 0,
	  initial_level: 0,
	  description: 'sicheres Metalllager',
	  condition: 99, tier: 2,
	  icon: 'Metalltresor.png'
	},
	{
	  name: 'Ressourcentresor Kristall',
	  costMineral: 2,
	  costCristal: 4,
	  costFuel: 0,
	  initial_level: 0,
	  description: 'sicheres Kristalllager',
	  condition: 99,
	  tier: 2,
	  icon: 'Kristalltresor.png'
	},
	{
	  name: 'Ressourcentresor Treibstoff',
	  costMineral: 2,
	  costCristal: 0,
	  costFuel: 2,
	  initial_level: 0,
	  description: 'sicheres Treibstofflager',
	  condition: 99,
	  tier: 2,
	  icon: 'Treibstofftresor.png'
	}
])
