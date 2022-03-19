extends Control

func _ready():
	#GameData.connect("new_tower_selected", self, "show")
	#GameData.connect("tower_unselected", self, "hide")
	hide()
	
func hide_self():
	self.visible = false
	
func show_self():
	self.visible = true
