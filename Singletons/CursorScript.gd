extends Node

var default = load("res://Assets/UI/Cursor/Cursor Default.png")
var green = load("res://Assets/UI/Cursor/Cursor Default Friends.png")
var red = load("res://Assets/UI/Cursor/Cursor Default Enemy.png")

#func set_cursor(area):
#	if area.is_in_group('cursor_green'):
#		Input.set_custom_mouse_cursor(green)
#	elif area.is_in_group('cursor_red'):
#		Input.set_custom_mouse_cursor(red)
#	else:
#		Input.set_custom_mouse_cursor(default)

func set_cursor(color):
	if color == 'green':
		Input.set_custom_mouse_cursor(green)
	elif color == 'red':
		Input.set_custom_mouse_cursor(red)
	else:
		Input.set_custom_mouse_cursor(default)
