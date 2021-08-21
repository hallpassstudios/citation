extends Camera2D

var target
var speed = 200

func _ready():
	target = globals.player

func _process(delta):
	var target_dir = (target.position - self.position).normalized()
	position += speed * target_dir * delta

