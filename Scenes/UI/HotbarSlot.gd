extends TextureButton

var type

func set_icon(icon):
	$Container/Icon.texture = load(icon)
