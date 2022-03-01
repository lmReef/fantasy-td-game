extends Sprite

var dead = false

func _ready():
	GameData.connect('health_lost', self, 'play_animation', ['hit'])
	GameData.connect('dead', self, 'play_animation', ['death'])

func play_animation(animation):
	if $AnimationPlayer.has_animation(animation) and not dead:
		$AnimationPlayer.play(animation)

func _on_AnimationPlayer_animation_finished(animation):
	if animation != 'death':
		play_animation('idle')
	else: dead = true
