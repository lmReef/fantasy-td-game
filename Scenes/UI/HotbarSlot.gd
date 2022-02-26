extends TextureButton

var stats = {}
var type

func set_icon(icon):
	$Container/Icon.texture = load(icon)

func _on_Slot_mouse_entered():
	get_node('/root/SceneHandler/GameScene/UI/HUD/Tooltip').set_text(type, stats.cost, stats)
	get_node('/root/SceneHandler/GameScene/UI/HUD/Tooltip').visible = true


func _on_Slot_mouse_exited():
	get_node('/root/SceneHandler/GameScene/UI/HUD/Tooltip').visible = false
