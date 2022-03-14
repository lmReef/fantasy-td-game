extends TextureRect

var info
	
func set_info(_info):
	info = _info
	texture = load(info.icon_path)
