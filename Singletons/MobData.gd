extends Node

var mobs = {
	'Scrapper': load('res://Scenes/Mobs/Scrapper.tscn').instance().stats,
	'Fighter': load('res://Scenes/Mobs/Fighter.tscn').instance().stats,
}

#func _ready():
	#print(filter_wave_available(30))

func filter_wave_available(wave):
	var filtered_mobs = []
	
	for key in mobs.keys():
		var value = mobs[key]
		if value.wave_available <= wave:
			filtered_mobs.append(key)
	
	return filtered_mobs
	
func filter_cost(cost):
	pass
