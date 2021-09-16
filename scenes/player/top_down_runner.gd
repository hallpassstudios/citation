extends KinematicBody2D

export(float) var speed = 128
var velocity = Vector2.ZERO
export var friction = 0.01
export var acceleration = 1

var current_scene

enum {
	IDLE,
	WALKING,
	INTERACTING
}

var is_colliding : bool = false

var PLAYER_STATE = WALKING

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	# animationState.travel("Idle2")
	pass

func _process(delta):
	pass
	
func get_input():
	var input = Vector2()
	if Input.is_action_pressed('ui_right'):
		input.x += 1
	if Input.is_action_pressed('ui_left'):
		input.x -= 1
	if Input.is_action_pressed('ui_down'):
		input.y += 1
	if Input.is_action_pressed('ui_up'):
		input.y -= 1
	return input

func _physics_process(delta):
	var direction = get_input()
	velocity = lerp(velocity, direction.normalized() * speed, acceleration)
	velocity = move_and_slide(velocity)
	if velocity == Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", direction)
		animationState.travel("Idle")
	else:
		if direction.x < 0:
			$"YSort/character".flip_h = true
		else:
			$"YSort/character".flip_h = false
		animationTree.set("parameters/Walk/blend_position", direction)
		
		# we are moving, so walk
		animationState.travel("Walk")
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		print("Collided with: ", collision.collider.name)
		if collision.collider.is_in_group("spikes"):
			get_parent().restart("OUCH! watch out for spikes!")


func _on_joystick_use_move_vector(move_vector):
	velocity = lerp(velocity, move_vector.normalized() * speed, acceleration)
	velocity = move_and_slide(velocity)
	animationTree.set("parameters/Walk/BlendSpace2D/blend_position", move_vector.normalized())
	# we are moving, so walk
	animationState.travel("Walk")
