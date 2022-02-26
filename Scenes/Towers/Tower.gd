extends Node2D

var Projectile = load('res://Scenes/Projectile.tscn')

var tower_range
var damage
var attack_speed
var attack_type

var cost
var level = 0
var tier = 1

var built = false
var mobs = []
var target
var ready = true

func _init(stats).():
	tower_range = stats.tower_range
	damage = stats.damage
	attack_speed = stats.attack_speed
	attack_type = stats.attack_type
	cost = stats.cost

#func _init(_tower_range = 0, _damage = 0, _attack_speed = 0, _attack_type = 'Projectile', _cost = 20).():
#	tower_range = _tower_range
#	damage = _damage
#	attack_speed = _attack_speed
#	attack_type = _attack_type
#	cost = _cost

func _ready():
	# set the range of the towers area2d
	$Range/Radius.shape.radius = tower_range / 2 # sets radius not diameter
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
	target.on_hit(damage)
	yield(get_tree().create_timer(attack_speed), "timeout")
	ready = true
	
func attack_with_projectile(texture):
	var proj = Projectile.instance()
	proj.setup(target.global_position)
	attack()
	

func _on_Range_body_entered(body):
	mobs.append(body.get_parent())

func _on_Range_body_exited(body):
	mobs.erase(body.get_parent())
	
func _on_AnimationPlayer_animation_finished(anim_name):
	$AnimationPlayer.play('idle')

# change cursor on hover
func _on_HoverDetect_mouse_entered():
	CursorScript.set_cursor('green')

func _on_HoverDetect_mouse_exited():
	CursorScript.set_cursor('default')
