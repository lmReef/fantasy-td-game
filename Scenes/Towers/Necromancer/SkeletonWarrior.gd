extends 'res://Scenes/Towers/Tower.gd'

var tower_name = 'Skeleton Warrior'

var _stats = {
	'tower_range': 250, 
	'damage': 18, 
	'attack_speed': 1.5, 
	'attack_type': 'Melee', 
	'cost': 35
}

func _init().(_stats):
	pass

# TODO: override the default tower attack
func attack():
	.attack()
	#.attack_with_projectile(projectile_texture)

func choose_attack_animation(num):
	$AnimationPlayer.play('attack_' + String(randi()%num+1))
