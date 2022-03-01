extends Node

var items = {
	'Dirk': {
		'name': 'Dirk',
		'description': "A simple dagger. It's quick though.",
		'rarity': 'common',
		'icon_path': 'res://Assets/Items/Common/Dirk.png',
		'effects': {
			'description': 'Attack speed +15%',
			'type': 'stat_multiplier',
			'attributes': {
				'attack_speed': 0.15,
			}
		}
	}
}

var rng = RandomNumberGenerator.new()

func get_drop():
	return items.common.Dirk

func get_item_info(item):
	return items[item]

func get_item_scene(item):
	var item_scene = load('res://Scenes/Items/Item.tscn').instance()
	item_scene.set_info(get_item_info(item))
	return item_scene
