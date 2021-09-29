extends KinematicBody2D

export(float) var speed = 75
var velocity = Vector2.ZERO
export var friction = 0.01
export var acceleration = 1
var can_move = true
var current_scene
var direction = Vector2.ZERO
var touch_active

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
	pass

func _process(delta):
	pass

func light_up():
	$Light2D.visible = true
	
func _input(event):
	direction = Vector2.ZERO
	if Input.is_action_pressed('ui_right'):
		direction.x += 1
	if Input.is_action_pressed('ui_left'):
		direction.x -= 1
	if Input.is_action_pressed('ui_down'):
		direction.y += 1
	if Input.is_action_pressed('ui_up'):
		direction.y -= 1

func _physics_process(delta):
	if !can_move:
		return
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
		if collision.collider.is_in_group("spikes"):
			globals.current_scene.restart("OUCH! watch out for spikes!", "they hurt")
	
func _on_joystick_use_move_vector(move_vector):
	if touch_active:
		direction = move_vector
