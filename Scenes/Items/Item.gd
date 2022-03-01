extends TextureRect

var info
	
func set_info(_info):
	info = _info
	texture = load(info.icon_path)

#
# drag and drop
#

func get_drag_data(position):
	var data = {}
	#data['item_name'] = info.name
	data['item_name'] = 'Dirk'
	
	var preview = self.duplicate()
	var control = Control.new()
	control.add_child(preview)
	preview.rect_position = -preview.rect_size / 2
	
	set_drag_preview(control)
	
	return data
	
func can_drop_data(position, data):
	return true
	return false
	
func drop_data(position, data):
	#modulate.a = 1
	pass
