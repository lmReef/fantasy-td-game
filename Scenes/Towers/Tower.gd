extends Node2D

var Projectile = load('res://Scenes/Projectile.tscn')

var stats = {
	'tower_range': 0, 
	'damage': 0, 
	'attack_speed': 0, 
	'attack_type': 'Projectile', 
	'cost': 9999
}

var level = 0
var tier = 1

var built = false
var mobs = []
var target
var ready = true

func _init(_stats).():
	stats = _stats

func _ready():
	# set the range of the towers area2d
	$Range/Radius.shape.radius = stats.tower_range / 2 # sets radius not diameter
	add_to_group('cursor_green')

func _physics_process(_delta):
	if mobs.size() != 0 and built:
		target_mob()
		turn()
		if ready:
			attack()
	else:
		target = null

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
		$AnimationPlayer.play('attack')
		var proj = Projectile.instance()
		proj.setup(target.global_position)
		get_parent().add_child(proj)
	target.on_hit(stats.damage)
	yield(get_tree().create_timer(stats.attack_speed), "timeout")
	ready = true
	
func attack_with_projectile(_texture):
	var proj = Projectile.instance()
	proj.setup(target.global_position)
	attack()
	

func _on_Range_body_entered(body):
	mobs.append(body.get_parent())

func _on_Range_body_exited(body):
	mobs.erase(body.get_parent())
	
func _on_AnimationPlayer_animation_finished(_anim_name):
	$AnimationPlayer.play('idle')

# change cursor on hover
func _on_HoverDetect_mouse_entered():
	CursorScript.set_cursor('green')

func _on_HoverDetect_mouse_exited():
	CursorScript.set_cursor('default')
