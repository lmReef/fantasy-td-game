extends GridContainer

var tower_instance = null

func can_drop_data(position, data):
	return true
	
func drop_data(position, data):
	if tower_instance:
		add_child(ItemData.get_item_scene(data.item_name))
		data.origin_reference.queue_free()
		tower_instance.add_item(data.item_name)
		get_tree().get_nodes_in_group('tower_stats')[0].update_stats(tower_instance.stats, tower_instance.get_total_item_bonuses(), tower_instance)
		
