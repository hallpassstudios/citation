extends KinematicBody2D

export(float) var character_speed = 300.0
var path = []
var target : Vector2 
var can_move: bool = true
export(int) var character_model = 0

enum {
	IDLE,
	WALKING,
	INTERACTING
}

var will_interact : bool = false
var will_travel : bool = false
var is_colliding : bool = false

var PLAYER_STATE = IDLE

#onread vars
onready var navigation_controller = get_node('/root/' + globals.current_scene.name + '/navigation')
onready var animationPlayer = $AnimationPlayer
onready var lightAnimation = $"light animation"
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var light = $light

func _ready():
	# set our player model and animations
	if globals.active_char == 1:
		$YSort/character.visible = true
		animationPlayer = $AnimationPlayer
		animationTree = $AnimationTree
		animationState = animationTree.get("parameters/playback")
	if globals.active_char == 2:
		$YSort/character2.visible = true
		animationPlayer = $AnimationPlayer2
		animationTree = $AnimationTree2
		animationState = animationTree.get("parameters/playback")
	if globals.active_char == 3:
		$YSort/character3.visible = true
		animationPlayer = $AnimationPlayer3
		animationTree = $AnimationTree3
		animationState = animationTree.get("parameters/playback")
		
	if globals.is_lit && globals.current_scene.get_name() == "library":
		lightAnimation.play("idle")
		light.visible = true
	else:
		light.visible = false
		

func _process(delta):
	var walk_distance = character_speed * delta
	move_along_path(walk_distance)
	match PLAYER_STATE:
		INTERACTING:
			print("I am interacting")
		IDLE:
			animationState.travel("Idle2")

func _unhandled_input(event):
	if !can_move:
		return
	if event.is_action_pressed("click"):
		_update_navigation_path(self.position, get_global_mouse_position())
	
	if event is InputEventScreenTouch:
		_update_navigation_path(self.position, get_canvas_transform().affine_inverse().xform(event.position))
		
func move_along_path(distance):
	if !can_move:
		return
	var last_point = self.position
	var direction = (target - position).normalized()

	# our animation states
	animationTree.set("parameters/Idle2/BlendSpace2D/blend_position", direction)
	animationTree.set("parameters/Walk2/BlendSpace2D/blend_position", direction)
	
	# we are moving, so walk
	animationState.travel("Walk2")
	
	while path.size():
		var distance_between_points = last_point.distance_to(path[0])
		# The position to move to falls between two points and not colliding
		var collision = move_and_collide(direction)
		if distance <= distance_between_points:
			if collision:
				PLAYER_STATE = IDLE
				set_process(false)
				return
			self.position = last_point.linear_interpolate(path[0], distance / distance_between_points)
			PLAYER_STATE = WALKING
			is_colliding = false
			return
		# The position is past the end of the segment.
		distance -= distance_between_points
		last_point = path[0]
		path.remove(0)
	# The character reached the end of the path.
	PLAYER_STATE = IDLE
	self.position = last_point
	set_process(false)

func _update_navigation_path(start_position, end_position):
	# get_simple_path is part of the Navigation2D class.
	# It returns a PoolVector2Array of points that lead you
	# from the start_position to the end_position.
	path = navigation_controller.get_simple_path(start_position, end_position, true)
	target = end_position
	# The first point is always the start_position.
	# We don't need it in this example as it corresponds to the character's position.
	path.remove(0)
	set_process(true)

func interact(value):
	if value:
		will_interact = true
	else:
		will_interact = false
		
func travel(value):
	print("player will travel")
	if value:
		will_travel = true
	else: 
		will_travel = false
