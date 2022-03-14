extends CanvasLayer

func _ready():
	# set the hotbar slot types; 'Slot1': 'Missle'
	for i in get_tree().get_nodes_in_group('build_buttons'):
		if GameData.hero_towers[i.get_name()]: 
			var temp = load('res://Scenes/Towers/' + GameData.hero_name + '/' + GameData.hero_towers[i.get_name()].name + '.tscn').instance()
			i.type = GameData.hero_towers[i.get_name()].name
			i.set_icon('res://Assets/Towers/' + GameData.hero_name + '/' + i.type + '/icon.png')
			i.stats = temp.stats
			temp.queue_free()	
	
	WaveData.connect('wave_over', self, 'move_button_up')
	GameData.connect('level_up', self, 'update_ui_level')
	GameData.connect('gold_updated', self, 'update_ui_gold')
	
	var hero_portrait = load('res://Scenes/Heroes/' + GameData.hero_name + '.tscn').instance()
	$HUD/Dashboard/Row/PlayerPortrait/Hero.add_child(hero_portrait)
		
# TODO: these could probably use signals for a bit of performance savings
func _process(_delta):
	update_ui_wave_info()
	update_ui_bars()
	
func set_tower_preview(tower_type, mouse_pos):
	var drag_tower = load('res://Scenes/Towers/' + GameData.hero_name + '/' + tower_type + ".tscn").instance()
	drag_tower.set_name('DragTower')
	drag_tower.modulate = Color('ad54ff3c')
	
	# range indicator
	var range_texture = Sprite.new()
	range_texture.position = Vector2(32,32)
	var scaling = drag_tower.stats.tower_range / 600.0
	range_texture.scale = Vector2(scaling, scaling)
	var texture = load('res://Assets/UI/range_overlay.png')
	range_texture.texture = texture
	range_texture.modulate = Color('ad54ff3c')
	
	var control = Control.new()
	control.add_child(drag_tower, true)
	control.add_child(range_texture, true)
	control.rect_position = mouse_pos
	control.set_name('TowerPreview')
	add_child(control, true)
	move_child(get_node('TowerPreview'), 0)

func update_tower_preview(new_pos, color):
	get_node('TowerPreview').rect_position = new_pos
	if get_node('TowerPreview/DragTower').modulate != Color(color):
		get_node('TowerPreview/DragTower').modulate = Color(color)
		get_node('TowerPreview/Sprite').modulate = Color(color)

func update_ui_wave_info():
	if WaveData.current_wave > 0:
		$HUD/WaveInfo/HBoxContainer/WaveNumberLabel.text = 'Wave ' + String(WaveData.current_wave)
		$HUD/WaveInfo/HBoxContainer/MobsLeftLabel.text = 'Mobs left ' + String(WaveData.mobs_left)

func update_ui_bars():
	$HUD/Dashboard/Row/Col/HealthBar.max_value = GameData.max_health
	$HUD/Dashboard/Row/Col/HealthBar.value = GameData.health
	$HUD/Dashboard/Row/Col/HealthBar/HPLabel.text = String(GameData.health) + '/' + String(GameData.max_health)
	
	$HUD/Dashboard/Row/Col/ExperienceBar.min_value = GameData.min_experience
	$HUD/Dashboard/Row/Col/ExperienceBar.max_value = GameData.max_experience
	$HUD/Dashboard/Row/Col/ExperienceBar.value = GameData.experience
	$HUD/Dashboard/Row/Col/ExperienceBar/EXPLabel.text = String(GameData.experience) + '/' + String(GameData.max_experience)

func update_ui_level():
	$HUD/Dashboard/Row/PlayerPortrait/LevelIcon/Level.text = String(GameData.level)

func update_ui_gold():
	$HUD/Dashboard/Row/Inventory/Col/GoldGroup/Row/Gold.text = String(GameData.gold)
	for i in get_tree().get_nodes_in_group('build_buttons'):
		if GameData.gold < i.stats.cost:
			i.modulate = Color('938383')
		else:
			i.modulate = Color('ffffff')

#
# GameControls
#

func _unhandled_input(event):
	if event.is_action_released("play_pause"):
		if $HUD/GameControls/Play.pressed:
			$HUD/GameControls/Play.emit_signal("pressed")

func _on_Play_pressed():
	if get_parent().build_mode:
		get_parent().cancel_build_mode()
		
	if WaveData.mobs_left == 0:
		get_parent().start_next_wave()
		move_button_down()
		
func move_button_down():
	$HUD/GameControls/Play.set_position($HUD/GameControls/Play.rect_position + Vector2(0, 33))
	
func move_button_up():
	$HUD/GameControls/Play.set_position($HUD/GameControls/Play.rect_position + Vector2(0, -33))

func _on_Fastforward_pressed():
	if get_parent().build_mode:
		get_parent().cancel_build_mode()
		
	if Engine.get_time_scale() != 1.0:
		Engine.set_time_scale(1.0)
	else:
		Engine.set_time_scale(3.0)

func _on_Skills_pressed():
	var skill_book = load('res://Scenes/UI/Skills/SkillBook.tscn').instance()
	get_tree().get_nodes_in_group('UI_root')[0].add_child(skill_book)
	
	
	
	
	
