extends Node2D

var Projectile = load('res://Scenes/Projectile.tscn')

var base_stats = {
	'tower_range': 0, 
	'damage': 0, 
	'attack_speed': 0, # attacks per second
	'attack_type': 'Projectile', 
	'cost': 9999
}

var item_bonuses = {
	'flat_stats': {
		'tower_range': 0,
		'damage': 0,
		'attack_speed': 0,
		'cost': 0
	},
	'stat_multiplier': {
		'tower_range': 1,
		'damage': 1,
		'attack_speed': 1,
		'cost': 1
	}
}

var stats = {
	'tower_range': 0, 
	'damage': 0, 
	'attack_speed': 0, 
	'attack_type': 'Projectile', 
	'cost': 9999
}

var insights = {
	'damage_done': 0,
	'kills': 0,
}

var items = []

var level = 0
var tier = 1

var built = false
var mobs = []
var target
var ready = true

func _init(_base_stats).():
	base_stats = _base_stats
	stats = base_stats

func _ready():
	add_to_group('cursor_green')
	# set the range of the towers area2d
	$Range/Radius.shape.radius = stats.tower_range / 2 # sets radius not diameter
	update_range()


func _physics_process(_delta):
	if mobs.size() != 0 and built:
		target_mob()
		turn()
		if ready:
			attack()
	else:
		target = null
		
func add_item(item):
	items.append(item)
	
	# add stats to item bonuses
	var item_info = ItemData.get_item_info(item)
	for key in item_info.effects.attributes:
		var value = item_info.effects.attributes[key]
		item_bonuses[item_info.effects.type][key] += value
	apply_item_bonuses_to_base_stats()

func apply_item_bonuses_to_base_stats():
	# start with the base stats
	stats = base_stats.duplicate()
	
	# apply the flat bonuses
	for key in item_bonuses.flat_stats:
		stats[key] += item_bonuses.flat_stats[key]
	# apply the multiplier bonuses
	for key in item_bonuses.stat_multiplier:
		stats[key] = stats[key] * item_bonuses.stat_multiplier[key]
		
# returns only the items calculated damage
func get_total_item_bonuses():
	var item_stats = stats.duplicate()
	
	for key in item_stats:
		if key != 'attack_type':
			item_stats[key] -= base_stats[key]
		
	return item_stats

func target_mob():
	var mob_progress = []
	for i in mobs:
		mob_progress.append(i.offset)
	target = mobs[mob_progress.find(mob_progress.max())]

func turn():
	# $Turret.look_at(target.position)
	if position.x > target.position.x:
		$Sprite.flip_h = true
	elif position.x < target.position.x:
		$Sprite.flip_h = false

func attack():
	ready = false
	if $AnimationPlayer:
		$AnimationPlayer.playback_speed = 1 * stats.attack_speed
		$AnimationPlayer.play('attack')
		#var proj = Projectile.instance()
		#proj.setup(target.global_position)
		#get_parent().add_child(proj)
	target.on_hit(stats.damage, self)
	var timer_speed = 1 / stats.attack_speed # 1 / attacks per second
	yield(get_tree().create_timer(timer_speed), "timeout")
	ready = true
	
func add_to_damage_done(amount):
	insights.damage_done += amount
	
func add_to_kills():
	insights.kills += 1
	
func attack_with_projectile(_texture):
	var proj = Projectile.instance()
	proj.setup(target.global_position)
	attack()
	
func update_range():
	var scaling = stats.tower_range / 600.0
	$Range/Preview.scale = Vector2(scaling, scaling)
	

func _on_Range_body_entered(body):
	mobs.append(body.get_parent())

func _on_Range_body_exited(body):
	mobs.erase(body.get_parent())

func _on_AnimationPlayer_animation_finished(anim_name):
	if 'attack' in anim_name:
		$AnimationPlayer.playback_speed = 1
		$AnimationPlayer.play('idle')

# change cursor on hover
func _on_TowerSelect_mouse_entered():
	CursorScript.set_cursor('green')

func _on_TowerSelect_mouse_exited():
	CursorScript.set_cursor('default')

# on tower clicked
func _on_TowerSelect_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed && self != null):
		GameData.new_tower_selected(self)

