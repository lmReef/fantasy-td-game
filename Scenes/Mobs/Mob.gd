extends PathFollow2D

var stats

var dead = false
	
func _ready():
	# TODO: be aware this line + mob stats implementation may cause some fokery
	stats = MobData.mobs[self.get_name().rstrip("0123456789")].duplicate()

	apply_difficulty_scaling()
	
	$HealthBar.max_value = stats.health
	$HealthBar.value = stats.health
	set_as_toplevel(true)
	$HealthBar.set_as_toplevel(true)

func _process(delta):
	move(delta)
	if unit_offset == 1.0:
		GameData.take_damage(stats.damage)
		WaveData.mob_died()
		queue_free()
	#flip_sprite()
	
func apply_difficulty_scaling():
	stats.health = stats.health * (WaveData.difficulty * 0.15)
	
func move(delta):
	set_offset(get_offset() + stats.movespeed * delta)
	if $HealthBar: $HealthBar.set_position(position - Vector2(20, 40))

# TODO: sus this somehow
func flip_sprite():
	#if position.x > get_parent().curve.get_closest_point(position).x:
	#	$KinematicBody2D/Sprite.set_flip_h(false)
	#elif position.x < get_parent().curve.get_closest_point(position).x:
	#	$KinematicBody2D/Sprite.set_flip_h(true)
	pass

func on_hit(hit_damage):
	stats.health -= hit_damage
	$AnimationPlayer.play('hit')
	$HealthBar.value = stats.health
	if stats.health <= 0 and not dead:
		dead = true # otherwise every attacking tower counts as a kill
		on_dead()

func on_dead():
	GameData.award_experience(stats.experience)
	GameData.update_gold(stats.gold)
	WaveData.mob_died()
	var drop = ItemData.get_drop(1)
	if drop:
		get_parent().add_child(drop)
		drop.position = global_position + Vector2(0, -25) + Vector2(rand_range(-20, 20), rand_range(-20, 20))
	
	yield(get_tree().create_timer(0.2), "timeout")
	self.queue_free()

func _on_AnimationPlayer_animation_finished(_anim_name):
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
