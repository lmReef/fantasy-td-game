extends 'res://Scenes/Towers/Tower.gd'

var projectile_texture = 'res://Assets/Projectiles/arrow_1_origin.png'

var tower_name = 'Skeleton Mage'

var _stats = {
	'tower_range': 350,
	'damage': 25,
	'attack_speed': 0.9,
	'attack_type': 'Projectile',
	'cost': 50
}

func _init().(_stats):
	pass

# TODO: override the default tower attack
func attack():
	.attack()
	#.attack_with_projectile(projectile_texture)
