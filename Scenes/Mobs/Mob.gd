extends PathFollow2D

var health
var movespeed
var experience
var damage
var gold

var dead = false

func _init(stats).():
	health = stats.health
	movespeed = stats.movespeed
	experience = stats.experience
	damage = stats.damage
	gold = stats.gold
	
func _ready():
	apply_difficulty_scaling()
	
	$HealthBar.max_value = health
	$HealthBar.value = health
	set_as_toplevel(true)
	$HealthBar.set_as_toplevel(true)

func _process(delta):
	move(delta)
	if unit_offset == 1.0:
		GameData.health -= damage
		queue_free()
	#flip_sprite()
	
func apply_difficulty_scaling():
	health = health * (WaveData.difficulty * 0.15)
	
func move(delta):
	set_offset(get_offset() + movespeed * delta)
	if $HealthBar: $HealthBar.set_position(position - Vector2(20, 40))

# TODO: sus this somehow
func flip_sprite():
	#if position.x > get_parent().curve.get_closest_point(position).x:
	#	$KinematicBody2D/Sprite.set_flip_h(false)
	#elif position.x < get_parent().curve.get_closest_point(position).x:
	#	$KinematicBody2D/Sprite.set_flip_h(true)
	pass

func on_hit(damage):
	health -= damage
	$AnimationPlayer.play('hit')
	$HealthBar.value = health
	if health <= 0 and not dead:
		dead = true # otherwise every attacking tower counts as a kill
		on_dead()

func on_dead():
	# award $$$
	GameData.award_experience(experience)
	GameData.update_gold(gold)
	WaveData.mob_died()
	$KinematicBody2D.queue_free()
	$HealthBar.queue_free()
	yield(get_tree().create_timer(0.2), "timeout")
	self.queue_free()

func _on_AnimationPlayer_animation_finished(anim_name):
	$AnimationPlayer.play('move')

# change cursor on hover
func _on_KinematicBody2D_mouse_entered():
	print('kin in')
	CursorScript.set_cursor('red')

func _on_KinematicBody2D_mouse_exited():
	print('kin out')
	CursorScript.set_cursor('default')

# change cursor on hover
func _on_HoverDetect_mouse_entered():
	CursorScript.set_cursor('red')

func _on_HoverDetect_mouse_exited():
	CursorScript.set_cursor('default')
