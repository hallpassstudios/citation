extends RigidBody2D

onready var quote_position = $"quote position"
var snap

func _physics_process(delta):
	if snap:
		apply_central_impulse(quote_position.position * delta * 200)

