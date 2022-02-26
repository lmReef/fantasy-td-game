extends Node2D

var map_node

var build_mode = false
var build_valid = false
var build_tile
var build_location
var build_type

func _ready():
	map_node = $Map1
	
	WaveData.connect('wave_over', self, '_on_wave_over')
	
	# set click hotbar stuff
	for i in get_tree().get_nodes_in_group('build_buttons'):
		i.connect('pressed', self, 'initiate_build_mode', [i.type])
		
	# set cursors
	Input.set_custom_mouse_cursor(load('res://Assets/UI/Cursor/Cursor Default.png'), Input.CURSOR_ARROW)
	Input.set_custom_mouse_cursor(load('res://Assets/UI/Cursor/Cursor Default Friends.png'), Input.CURSOR_POINTING_HAND)
	Input.set_custom_mouse_cursor(load('res://Assets/UI/Cursor/Cursor Default Enemy.png'), Input.CURSOR_FORBIDDEN)
	
func _process(_delta):
	if build_mode:
		update_tower_preview()
	
func _unhandled_input(event):
	if event.is_action_released("ui_cancel") and build_mode:
		cancel_build_mode()
	elif event.is_action_released("ui_accept") and build_mode and build_valid:
		verify_and_build()
		cancel_build_mode()
		
	# hotbar controls
	if event.is_action_released('hotbar_1'):
		initiate_build_mode(get_tree().get_nodes_in_group('build_buttons')[0].type)
	elif event.is_action_released('hotbar_2'):
		initiate_build_mode(get_tree().get_nodes_in_group('build_buttons')[1].type)
	elif event.is_action_released('hotbar_3'):
		initiate_build_mode(get_tree().get_nodes_in_group('build_buttons')[2].type)
	elif event.is_action_released('hotbar_4'):
		initiate_build_mode(get_tree().get_nodes_in_group('build_buttons')[3].type)
	elif event.is_action_released('hotbar_5'):
		initiate_build_mode(get_tree().get_nodes_in_group('build_buttons')[4].type)
	elif event.is_action_released('hotbar_6'):
		initiate_build_mode(get_tree().get_nodes_in_group('build_buttons')[5].type)
		
#
# wave functions
#

func start_next_wave():
	WaveData.current_wave += 1
	WaveData.mobs_left = WaveData.waves[WaveData.current_wave].size()
	var wave_data = WaveData.waves[WaveData.current_wave]
	yield(get_tree().create_timer(0.2), "timeout") # padding between waves, 'build time'
	spawn_mobs(wave_data)
	
func spawn_mobs(wave_data):
	var rng = RandomNumberGenerator.new()
	for i in wave_data:
		var new_mob = load('res://Scenes/Mobs/' + i + '.tscn').instance()
		map_node.get_node('Path').add_child(new_mob, true)
		yield(get_tree().create_timer(rng.randf_range(0.3, 1)), "timeout")


#
# build functions
#

func initiate_build_mode(tower_type):
	if build_mode:
		cancel_build_mode()
	build_type = tower_type
	build_mode = true
	$UI.set_tower_preview(build_type, get_global_mouse_position())
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$Grid.on = true
	
func update_tower_preview():
	var mouse_pos = get_global_mouse_position()
	var current_tile = map_node.get_node('TowerExclusion').world_to_map(mouse_pos)
	var tile_position = map_node.get_node('TowerExclusion').map_to_world(current_tile)
	
	if map_node.get_node('TowerExclusion').get_cellv(current_tile) == -1 and map_node.get_node('TowerExclusion').get_cellv(current_tile + Vector2(1, 0)) == -1 and map_node.get_node('TowerExclusion').get_cellv(current_tile + Vector2(0, 1)) == -1 and map_node.get_node('TowerExclusion').get_cellv(current_tile + Vector2(1, 1)) == -1:
		$UI.update_tower_preview(tile_position, 'ad54ff3c')
		build_valid = true
		build_location = tile_position
		build_tile = current_tile
	else:
		$UI.update_tower_preview(tile_position, 'adff4545')
		build_valid = false
	
func cancel_build_mode():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Grid.on = false
	build_mode = false
	build_valid = false
	$UI/TowerPreview.free()
	
func verify_and_build():
	if build_valid:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$Grid.on = false
		# check to see if enough $
		var new_tower = load('res://Scenes/Towers/' + build_type + '.tscn').instance()
		new_tower.position = build_location
		new_tower.built = true
		map_node.get_node('YSort/Towers').add_child(new_tower, true)
		map_node.get_node('TowerExclusion').set_cellv(build_tile, 27)
		map_node.get_node('TowerExclusion').set_cellv(build_tile + Vector2(1, 0), 27)
		map_node.get_node('TowerExclusion').set_cellv(build_tile + Vector2(0, 1), 27)
		map_node.get_node('TowerExclusion').set_cellv(build_tile + Vector2(1, 1), 27)
		# deduct $
		# update $ label

func _on_wave_over():
	print('wave has ended')




