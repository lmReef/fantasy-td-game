extends GridContainer

var tower_instance = null

func can_drop_data(position, data):
	return true
	
func drop_data(position, data):
	if tower_instance:
		add_child(ItemData.get_item_scene(data.item_name))
		tower_instance.add_item(data.item_name)
		
