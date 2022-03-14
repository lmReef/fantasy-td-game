extends Node

var hero_name = 'Necromancer'
var hero_skills
var hero_towers

var selected_tower = null

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
signal new_tower_selected
signal tower_unselected

func _ready():
	randomize()
	update_hero_info()

func new_tower_selected(new_tower):
	if selected_tower != null:
		tower_unselected()
	selected_tower = new_tower
	#get_tree().get_nodes_in_group('tower_stats')[0].update_stats()
	emit_signal('new_tower_selected')

func tower_unselected():
	GameData.selected_tower.get_node('Range').visible = false
	selected_tower = null
	get_tree().get_nodes_in_group('tower_inv')[0].hide_panel()
	get_tree().get_nodes_in_group('tower_stats')[0].hide_panel()
	emit_signal('tower_unselected')

func update_hero_info():
	var file = File.new()
	file.open('res://Resources/HeroData/' + hero_name + '.json', file.READ)
	var json = file.get_as_text()
	var json_result = JSON.parse(json).result
	
	hero_skills = json_result.hero_skills
	hero_towers = json_result.hero_towers
	
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
