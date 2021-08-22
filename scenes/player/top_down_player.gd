extends KinematicBody2D

enum {
	IDLE = 0,
	WALKING = 1,
	INTERACTING = 2
}

export(int) var speed = 200
var target = Vector2()
var velocity = Vector2()
var state = IDLE
var will_interact : bool

#onread vars
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _input(event):
	# mouse movement input
	if event.is_action_pressed("click"):
		target = get_global_mouse_position()
		will_interact = false;
		# print("clicked at: ", target)
	# and touch input
	if event is InputEventScreenTouch:
		target = get_canvas_transform().affine_inverse().xform(event.position)
		# print("touched at: ", target)

func _physics_process(delta):
	velocity = position.direction_to(target) * speed
	
	# what are we colliding with?
	
	# our animation states
	animationTree.set("parameters/Idle2/BlendSpace2D/blend_position", velocity.normalized())
	animationTree.set("parameters/Walk2/BlendSpace2D/blend_position", velocity.normalized())
	
	# animate based on our current player state, easy to add other animations this way. Amazing.
	match state:
		IDLE:
			animationState.travel("Idle2")
		WALKING:
			animationState.travel("Walk2")
		INTERACTING:
			print("I am interacting!")
	
	# move the player
	if position.distance_to(target) > 5:
		move(delta)
	else:
		state = IDLE
		
func move(delta):
	velocity = move_and_collide(velocity * delta)
	
	if velocity != null:
		state = IDLE
	else:
		state = WALKING
func move_and_interact():
	will_interact = true
	print("we're going to move and interact")


func _on_Area2D_input_event(viewport, event, shape_idx):
	print("input event!")
