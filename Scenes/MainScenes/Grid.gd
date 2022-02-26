extends Node2D

export var on = false

func _draw():
	if on: 
		var size = get_viewport_rect().size
		
		for i in range(0, size.y, 32):
			draw_line(Vector2(0, i), Vector2(size.x, i), "1a000000")
			
		for i in range(0, size.x, 32):
			draw_line(Vector2(i, 0), Vector2(i, size.y), "1a000000")
		
		#for i in range(int(size.x / 64) - 1, int(size.x / 64) + 1):
			#draw_line(Vector2(i * 64, size.y), Vector2(i * 64, size.y), "000000")
			
		#for i in range(int(size.y / 64) - 1, int(size.y / 64) + 1):
		#	draw_line(Vector2(size.x + 100, i * 64), Vector2(size.x - 100, i * 64), "000000")

func _process(_delta):
	update()
