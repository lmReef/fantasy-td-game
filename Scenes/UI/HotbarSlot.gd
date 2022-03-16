extends TextureButton

var stats = {}
var type

func set_icon(icon):
	$Container/Icon.texture = load(icon)
	$Container/Icon.rect_pivot_offset = Vector2(30, 20)
	$Container/Icon.rect_scale = Vector2(2, 2)

func _on_Slot_mouse_entered():
	var desc = 'Damage: {damage}\nAttack Speed: {attack_speed}\nRange: {range}\nAttack Type: {attack_type}'.format({
		'damage': stats.damage,
		'attack_speed': stats.attack_speed,
		'range': stats.tower_range,
		'attack_type': stats.attack_type
	})
	var pos = Vector2(rect_global_position.x + rect_size.x/2, rect_global_position.y)
	
	get_tree().get_nodes_in_group('Tooltip')[0].show_tooltip(
		type, desc, pos, stats.cost
	)

func _on_Slot_mouse_exited():
	get_tree().get_nodes_in_group('Tooltip')[0].hide_tooltip()
