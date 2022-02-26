extends Node

var champion_name = 'Necromancer'

var level = 1
var experience = 0
var max_experience = 100
var min_experience = 0
var health = 10
var max_health = 10
var gold = 50

signal level_up

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
	max_experience = level * 100 * 1.1
	emit_signal("level_up")
	
	# check for xp overflow
	if experience >= max_experience:
		level_up()

func award_experience(awarded):
	experience += awarded
	
	if experience >= max_experience:
		level_up()
