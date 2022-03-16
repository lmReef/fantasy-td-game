extends Node

var mobs = {
	'Scrapper': {
		'health': 20,
		'movespeed': 200,
		'damage': 1,
		'experience': 15,
		'gold': 1,
		'cost': 10,
		'wave_available': 0,
		'drop_chances': 1
	},
	'Fighter': {
		'health': 38,
		'movespeed': 190,
		'damage': 1,
		'experience': 19,
		'gold': 2,
		'cost': 20,
		'wave_available': 5,
		'drop_chances': 1
	},
}

func filter_wave_available(wave):
	var filtered_mobs = []
	
	for key in mobs.keys():
		var value = mobs[key]
		if value.wave_available <= wave:
			filtered_mobs.append(key)
	
	return filtered_mobs
	
func filter_cost(_cost):
	# TODO: func to filter by min cost
	pass
