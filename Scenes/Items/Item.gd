extends TextureRect

var info
var dragable = false # TODO: make items only dragable sometimes
# TODO: maybe make a seperate 'drop' scene in place of items on the ground

func set_info(_info):
	info = _info
	texture = load(info.icon_path)

func set_dragable(_dragable):
	dragable = _dragable

#
# drag and drop
#

func get_drag_data(position):
	if dragable:
		var data = {}
		data['item_name'] = info.name
		data['origin_reference'] = self
		
		var preview = self.duplicate()
		var control = Control.new()
		control.add_child(preview)
		preview.rect_position = -preview.rect_size / 2
		
		set_drag_preview(control)
		
		return data
	
#func can_drop_data(position, data):
#	return true
#	return false
	
#func drop_data(position, data):
	#modulate.a = 1
#	pass


func _on_Item_mouse_entered():
	var title = info.name
	var desc = '{effect}\n{desc}'.format({
		'effect': info.effects.description,
		'desc': info.description
	})
	var pos = Vector2(rect_global_position.x + rect_size.x/2, rect_global_position.y + 20)
	#var pos = Vector2(get_parent().get_parent().rect_global_position.x, get_parent().get_parent().rect_global_position.y)
	
	get_tree().get_nodes_in_group('Tooltip')[0].show_tooltip(
		title, desc, pos
	)


func _on_Item_mouse_exited():
	get_tree().get_nodes_in_group('Tooltip')[0].hide_tooltip()
