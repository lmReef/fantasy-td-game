extends Control

func show_tooltip(title, desc, pos, cost):
	# set title and description
	$NinePatchRect/Col/Row/Title.text = title.capitalize()
	$NinePatchRect/Col/Stats.text = desc
	
	# if cost param is passed then set it, otherwise hide the cost control group
	if cost:
		$NinePatchRect/Col/Row/CostGroup/Cost.text = String(cost)
		$NinePatchRect/Col/Row/CostGroup.visible = true
	else:
		$NinePatchRect/Col/Row/CostGroup.visible = false
		
	set_global_position(
		pos - Vector2($NinePatchRect.rect_size.x/2, $NinePatchRect.rect_size.y + 48)
	)
	
	visible = true

func hide_tooltip():
	visible = false
