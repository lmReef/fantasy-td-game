extends Node

var hero = 'Necromancer'

var level = 1
var experience = 0
var max_experience = 100
var min_experience = 0
var health = 10
var max_health = 10
var gold = 50

signal level_up
signal gold_updated
signal health_lost
signal dead

var hotbar_towers = {
	'Slot1': {
		'name': 'SkeletonArcher',
		'icon_location': 'res://Assets/Icons/Towers/SkeletonArcher.png'
	},
	'Slot2': {
		'name': 'SkeletonArcher',
		'icon_location': 'res://Assets/Icons/Towers/SkeletonArcher.png'
	},
	'Slot3': {
		'name': 'SkeletonArcher',
		'icon_location': 'res://Assets/Icons/Towers/SkeletonArcher.png'
	},
	'Slot4': {
		'name': 'SkeletonArcher',
		'icon_location': 'res://Assets/Icons/Towers/SkeletonArcher.png'
	},
	'Slot5': {
		'name': 'SkeletonArcher',
		'icon_location': 'res://Assets/Icons/Towers/SkeletonArcher.png'
	},
	'Slot6': {
		'name': 'SkeletonArcher',
		'icon_location': 'res://Assets/Icons/Towers/SkeletonArcher.png'
	},
}

# TODO: probably make this use signals instead for performance
#func _process(delta):
#	if experience >= max_experience:
#		level_up()

func level_up():
	level += 1
	min_experience = max_experience
	max_experience = int(level * 100 * (WaveData.difficulty * 0.5))
	emit_signal("level_up")
	
	# check for xp overflow
	if experience >= max_experience:
		level_up()

func award_experience(awarded):
	experience += awarded
	
	if experience >= max_experience:
		level_up()
		
func update_gold(amount):
	gold += amount
	emit_signal('gold_updated')

func take_damage(amount):
	health -= amount
	if health <= 0:
		emit_signal("dead")
	else:
		emit_signal("health_lost")
