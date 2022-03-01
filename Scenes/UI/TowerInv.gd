extends NinePatchRect

var items = []

func _ready():
	visible = false

func set_items(_items, _tower_instance):
	if _tower_instance.get_name() != 'DragTower':
		items = _items
		
		$Col/Title.text = _tower_instance.get_name().capitalize() + "'s items"
		$Col/NinePatchRect/ScrollContainer/TowerInvGrid.tower_instance = _tower_instance
		
		for child in $Col/NinePatchRect/ScrollContainer/TowerInvGrid.get_children(): child.queue_free()
		for i in items:
			$Col/NinePatchRect/ScrollContainer/TowerInvGrid.add_child(ItemData.get_item_scene(i))
		visible = true

func hide_panel():
	items = []
	$Col/NinePatchRect/ScrollContainer/TowerInvGrid.tower_instance = null
	visible = false
