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

var common_items = []
var rare_items = []
var legendary_items = []
var cursed_items = []

var rng = RandomNumberGenerator.new()

func _ready():
	for key in items:
		if items[key].rarity == 'common': common_items.append(key)
		elif items[key].rarity == 'rare': rare_items.append(key)
		elif items[key].rarity == 'legendary': legendary_items.append(key)
		elif items[key].rarity == 'cursed': cursed_items.append(key)

func get_drop(chances):
	var roll = 0
	
	for i in chances:
		var roll_chance = rng.randi_range(0, 100)
		if roll < roll_chance: roll = roll_chance
	
	if roll > 0:
		return get_item_scene(items[common_items[rng.randi_range(0, common_items.size()-1)]].name)
	elif roll > 99:
		return get_item_scene(items[legendary_items[rng.randi_range(0, legendary_items.size()-1)]].name)
	elif roll > 95:
		return get_item_scene(items[rare_items[rng.randi_range(0, rare_items.size()-1)]].name)
	elif roll > 80:
		return get_item_scene(items[common_items[rng.randi_range(0, common_items.size()-1)]].name)
	elif roll < 0:
		return get_item_scene(items[cursed_items[rng.randi_range(0, cursed_items.size()-1)]].name)
	
func get_item_info(item):
	return items[item]

func get_item_scene(item):
	if item:
		var item_scene = load('res://Scenes/Items/Item.tscn').instance()
		item_scene.set_info(get_item_info(item))
		return item_scene
	else: return null
