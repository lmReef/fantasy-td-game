extends NinePatchRect

func add_item(_item, origin_scene):
	var item = ItemData.get_item_scene(_item.name)
	item.set_dragable(true)

	$Col/ScrollContainer/PlayerInvGrid.add_child(item)
	origin_scene.queue_free()
