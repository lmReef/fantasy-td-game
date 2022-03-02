extends Node2D

var collected = false
onready var inv = get_tree().get_nodes_in_group('player_inv')[0]
onready var positionA = global_position
onready var positionB = inv.rect_global_position + Vector2(110, 75)
onready var positionC = global_position + Vector2(rand_range(-300, 300), rand_range(-200, 200))

var t = 0.0
var duration = 1.0

func _process(delta):
	if collected:
		if global_position == positionB:
			inv.add_item($Item.info.duplicate(), self)
			
		t += delta / duration
		var q0 = positionA.linear_interpolate(positionC, min(t, 1.0))
		var q1 = positionC.linear_interpolate(positionB, min(t, 1.0))
		global_position = q0.linear_interpolate(q1, min(t, 1.0))

func set_info(_info):
	$Item.set_info(_info)

func _on_Area2D_mouse_entered():
	collected = true
	positionA = global_position
