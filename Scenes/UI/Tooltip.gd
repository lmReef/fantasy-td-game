extends Control

func show_tooltip(title, desc, pos, cost = null):
	# set title and description
	$MarginContainer/MarginContainer/Col/Header/Title.text = title.capitalize()
	$MarginContainer/MarginContainer/Col/Body.text = desc
	
	# if cost param is passed then set it, otherwise hide the cost control group
	if cost:
		$MarginContainer/MarginContainer/Col/Header/CostGroup/Cost.text = String(cost)
		$MarginContainer/MarginContainer/Col/Header/CostGroup.visible = true
	else:
		$MarginContainer/MarginContainer/Col/Header/CostGroup.visible = false
		
	set_global_position(
		pos - Vector2($MarginContainer.rect_size.x/2, $MarginContainer.rect_size.y + 48)
	)
	
	visible = true

func hide_tooltip():
	visible = false
