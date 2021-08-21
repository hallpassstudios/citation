extends RigidBody2D

var velocity = Vector2.ZERO
var speed = 1500
var gravity = 500
export (bool) var correct

onready var progress = $CollisionShape2D/CenterContainer/TextureProgress

func _ready():
	progress.value = 100

func hit(damage):
	progress.value -= damage
	if correct:
		globals.player_score -= 10
	else:
		globals.player_score += 10
	
func _process(delta):
	if progress.value == 0:
		queue_free()
