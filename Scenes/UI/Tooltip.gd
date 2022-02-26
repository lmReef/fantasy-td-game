extends Control

func _process(delta):
	#set_global_position(get_global_mouse_position() - Vector2(0, $NinePatchRect.rect_size.y))
	set_global_position(get_global_mouse_position() - $NinePatchRect.rect_size)

func set_text(title, cost, stats):
	$NinePatchRect/Col/Row/Title.text = title
	$NinePatchRect/Col/Row/CostGroup/Cost.text = String(cost)
	$NinePatchRect/Col/Stats.text = 'Damage: {damage}\nAttack Speed: {attack_speed}\nRange: {range}\nAttack Type: {attack_type}'.format({
		'damage': stats.damage,
		'attack_speed': stats.attack_speed,
		'range': stats.tower_range,
		'attack_type': stats.attack_type
	})
