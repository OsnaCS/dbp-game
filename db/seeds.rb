# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Science.create([
	{
		id: 1000,
		cost1: 10,
		cost2: 0,
		cost3: 0,
		factor: 2,
		duration: 60,
		condition: '',
		name: 'Hülle',
		tier: 1,
		science_condition_id: 1,
		icon: 'huelle.png'
	},
	{
		id: 1001,
		cost1: 4,
		cost2: 3,
		cost3: 0,
		factor: 2,
		duration: 60,
		condition: '',
		name: 'Laser',
		tier: 1,
		science_condition_id: 2,
		icon: 'laser.png'
	},
	{
		id: 1002,
		cost1: 0,
		cost2: 3,
		cost3: 1,
		factor: 2,
		duration: 60,
		condition: '',
		name: 'Spionage',
		tier: 1,
		science_condition_id: 3,
		icon: 'spionage.png'
	},
	{
		id: 1003,
		cost1: 8,
		cost2: 0,
		cost3: 3,
		factor: 2,
		duration: 120,
		condition: 'f:1:4',
		name: 'Triebwerke',
		tier: 2,
		science_condition_id: 4,
		icon: 'triebwerke.png'
	},
	{
		id: 1004,
		cost1: 4,
		cost2: 8,
		cost3: 0,
		factor: 2,
		duration: 120,
		condition: 'f:2:10',
		name: 'Ionen',
		tier: 2,
		science_condition_id: 5,
		icon: 'ionen.png'
	},
	{
		id: 1005,
		cost1: 0,
		cost2: 6,
		cost3: 2,
		factor: 2,
		duration: 120,
		condition: 'f:1:10,f:5:2',
		name: 'Schild',
		tier: 2,
		science_condition_id: 6,
		icon: 'schilde.png'
	},
	{
		id: 1006,
		cost1: 20,
		cost2: 0,
		cost3: 5,
		factor: 2,
		duration: 240,
		condition: 'f:4:4',
		name: 'Pilotentraining',
		tier: 3,
		science_condition_id: 7,
		icon: 'pilotentraining.png'
	},
	{
		id: 1007,
		cost1: 20,
		cost2: 10,
		cost3: 0,
		factor: 2,
		duration: 240,
		condition: 'f:5:10',
		name: 'Kinetik',
		tier: 3,
		science_condition_id: 8,
		icon: 'kinetik.png'
	},
	{
		id: 1008,
		cost1: 320,
		cost2: 0,
		cost3: 100,
		factor: 2,
		duration: 43200,
		condition: 'f:7:8',
		name: 'Pioniersausbildung',
		tier: 4,
		science_condition_id: 9,
		icon: 'pioniersausbildung.png'
	},
	{
		id: 1009,
		cost1: 0,
		cost2: 160,
		cost3: 100,
		factor: 2,
		duration: 43200,
		condition: 'f:3:12',
		name: 'Netzwerk',
		tier: 4,
		science_condition_id: 10,
		icon: 'netzwerk.png'
	}
])