extends KinematicBody2D

var target
var speed
var velocity

#func _init(_target, _speed = 12, _texture = null).():
	
func _physics_process(delta):
	if target:
		velocity = global_position.direction_to(target) * speed
		if global_position.distance_to(target) > 0:
			velocity = move_and_slide(velocity)
	else:
		queue_free()

func setup(_target, _speed = 5, _texture = null):
	if $Sprite.texture: $Sprite.texture = _texture
	target = _target
	speed = _speed
