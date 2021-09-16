extends Sprite

const VELOCITY: float = -1.5
var g_texture_width: float = 0

func _ready():
	g_texture_width = texture.get_size().y * scale.y

func _process(delta):
	position.y += VELOCITY
	_attempt_reposition()

func _attempt_reposition():
	if position.y < -g_texture_width/8:
		# don't just reset, otherwise we have a gap
		position.y += g_texture_width/8
