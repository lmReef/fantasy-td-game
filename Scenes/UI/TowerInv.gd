extends NinePatchRect

var items = []

func _ready():
	visible = false
	
	GameData.connect("new_tower_selected", self, "set_items")

func set_items():
	if GameData.selected_tower.get_name() != 'DragTower':
		items = GameData.selected_tower.items
		
		$Col/Title.text = GameData.selected_tower.tower_name + "'s items"
		$Col/NinePatchRect/ScrollContainer/TowerInvGrid.tower_instance = GameData.selected_tower
		
		for child in $Col/NinePatchRect/ScrollContainer/TowerInvGrid.get_children(): child.queue_free()
		for i in items:
			$Col/NinePatchRect/ScrollContainer/TowerInvGrid.add_child(ItemData.get_item_scene(i))
		visible = true

func hide_panel():
	items = []
	$Col/NinePatchRect/ScrollContainer/TowerInvGrid.tower_instance = null
	visible = false
