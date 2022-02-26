extends Node

func _ready():
	$MainMenu/MarginContainer/VBoxContainer/Play.connect('pressed', self, 'on_play_pressed')
	$MainMenu/MarginContainer/VBoxContainer/Exit.connect('pressed', self, 'on_exit_pressed')

func on_play_pressed():
	$MainMenu.queue_free()
	var game_scene = load('res://Scenes/MainScenes/GameScene.tscn').instance()
	add_child(game_scene)
	
func on_exit_pressed():
	get_tree().quit()
