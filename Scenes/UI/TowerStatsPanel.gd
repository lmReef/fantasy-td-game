extends NinePatchRect

func _ready():
	visible = false
	
	GameData.connect("new_tower_selected", self, "update_stats")

func update_stats():
	if GameData.selected_tower.get_name() != 'DragTower':
		var total_stats = GameData.selected_tower.stats
		var item_stats = GameData.selected_tower.get_total_item_bonuses()
		
		$Col/Title.text = GameData.selected_tower.get_name().capitalize()
		
		$Col/Stats/Damage/Total.text = String(total_stats.damage)
		$Col/Stats/Damage/Items.text = '(+' + String(item_stats.damage) + ')'
		$Col/Stats/Damage/Skills.text = '(+0)'
		
		$Col/Stats/AttackSpeed/Total.text = String(total_stats.attack_speed)
		$Col/Stats/AttackSpeed/Items.text = '(+' + String(item_stats.attack_speed) + ')'
		$Col/Stats/AttackSpeed/Skills.text = '(+0)'
		
		$Col/Stats/Range/Total.text = String(total_stats.tower_range)
		$Col/Stats/Range/Items.text = '(+' + String(item_stats.tower_range) + ')'
		$Col/Stats/Range/Skills.text = '(+0)'
		
		visible = true

func hide_panel():
	visible = false
