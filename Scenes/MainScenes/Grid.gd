extends Node2D

export var on = false

func _draw():
	if on: 
		var size = get_viewport_rect().size
		
		for i in range(0, size.y, 32):
			draw_line(Vector2(0, i), Vector2(size.x, i), "1a000000")
			
		for i in range(0, size.x, 32):
			draw_line(Vector2(i, 0), Vector2(i, size.y), "1a000000")

func _process(_delta):
	update()
