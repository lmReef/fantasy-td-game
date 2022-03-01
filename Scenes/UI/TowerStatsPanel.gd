extends NinePatchRect

var tower_instance

func _ready():
	visible = false

func update_stats(total_stats, item_stats, _tower_instance):
	if _tower_instance.get_name() != 'DragTower':
		tower_instance = _tower_instance
		
		$Col/Title.text = tower_instance.get_name().capitalize()
		
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
	tower_instance = null
	visible = false
