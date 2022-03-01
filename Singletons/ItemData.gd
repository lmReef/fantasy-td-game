extends Node

var items = {
	'Dirk': {
		'name': 'Dirk',
		'description': "A simple dagger. It's quick though.",
		'rarity': 'common',
		'icon_path': 'res://Assets/Items/Common/Dirk.png',
		'effects': {
			'description': 'Attack speed +15%',
			'type': 'multiplier',
			'attributes': {
				'attack_speed': 1.15,
			}
		}
	}
}

var rng = RandomNumberGenerator.new()

func get_drop():
	return items.common.Dirk
