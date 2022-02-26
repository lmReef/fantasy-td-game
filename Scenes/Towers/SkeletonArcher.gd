extends 'res://Scenes/Towers/Tower.gd'

var projectile_texture = 'res://Assets/Projectiles/arrow_1_origin.png'

var _stats = {
	'tower_range': 350, 
	'damage': 12, 
	'attack_speed': 1, 
	'attack_type': 'Projectile', 
	'cost': 20
}

func _init().(_stats):
	pass

#func _init().(350, 12, 1, 'Projectile', 20):
#	pass

# override the default tower attack
func attack():
	.attack()
	#.attack_with_projectile(projectile_texture)
