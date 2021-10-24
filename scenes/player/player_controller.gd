extends KinematicBody2D

export(float) var character_speed = 300.0
var path = []
var target : Vector2 
var can_move: bool = true
export(int) var character_model = 0

var velocity = Vector2.ZERO
var direction = Vector2.ZERO
var last_facing : Vector2
export var acceleration = 1

enum {
	IDLE,
	WALKING,
	INTERACTING
}

var will_interact : bool = false
var will_travel : bool = false
var is_colliding : bool = false
var using_keyboard : bool = false

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
		
func _input(event):
	direction = Vector2.ZERO
	if Input.is_action_pressed('ui_right'):
		direction.x += 1
		using_keyboard = true
		clear_path()
	if Input.is_action_pressed('ui_left'):
		direction.x -= 1
		using_keyboard = true
		clear_path()
	if Input.is_action_pressed('ui_down'):
		direction.y += 1
		using_keyboard = true
		clear_path()
	if Input.is_action_pressed('ui_up'):
		direction.y -= 1
		using_keyboard = true
		clear_path()
	
func _process(delta):

	if !can_move:
		PLAYER_STATE = IDLE
		return
		
	# keyboard movement
	keyboard_movement()
	# click to move
	if !using_keyboard:
		var walk_distance = character_speed * delta
		move_along_path(walk_distance)
	
	match PLAYER_STATE:
		WALKING:
			animationState.travel("Walk")
		IDLE:
			animationState.travel("Idle")

func _unhandled_input(event):
	if !can_move:
		PLAYER_STATE = IDLE
		return
		
	if event.is_action_pressed("click"):
		_update_navigation_path(self.position, get_global_mouse_position())
	
	if event is InputEventScreenTouch:
		_update_navigation_path(self.position, get_canvas_transform().affine_inverse().xform(event.position))
		
func keyboard_movement():
	velocity = lerp(velocity, direction.normalized() * character_speed, acceleration)
	velocity = move_and_slide(velocity)
	
	if velocity == Vector2.ZERO:
		using_keyboard = false
		PLAYER_STATE = IDLE
		animationTree.set("parameters/Idle/blend_position", last_facing)
	else:
		using_keyboard = true
		PLAYER_STATE = WALKING
		animationTree.set("parameters/Walk/blend_position", direction)
		last_facing = direction.normalized()

func clear_path():
	for i in path.size():
		path.remove(i)
		
func move_along_path(distance):
	if !can_move:
		PLAYER_STATE = IDLE
		return
		
	var last_point = self.position
	var direction = (target - position).normalized()

	# our animation states
	animationTree.set("parameters/Idle/blend_position", last_facing)
	animationTree.set("parameters/Walk/blend_position", direction)
	
	# we are moving, so walk
	animationState.travel("Walk2")

	while path.size():
		last_facing = (target - position).normalized()
		# animationState.travel("Walk2")
		var distance_between_points = last_point.distance_to(path[0])
		# The position to move to falls between two points and not colliding
		var collision = move_and_collide(direction)
		if distance <= distance_between_points:
			if collision:
				PLAYER_STATE = IDLE
				# set_process(false)
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
	#set_process(false)

func _update_navigation_path(start_position, end_position):
	# get_simple_path is part of the Navigation2D class.
	# It returns a PoolVector2Array of points that lead you
	# from the start_position to the end_position.
	path = navigation_controller.get_simple_path(start_position, end_position, true)
	target = end_position
	# The first point is always the start_position.
	# We don't need it in this example as it corresponds to the character's position.
	path.remove(0)
	#set_process(true)

func interact(value):
	if value:
		will_interact = true
	else:
		will_interact = false
		
func travel(value):
	if value:
		will_travel = true
	else: 
		will_travel = false

func camera_off():
	print("turning camera off")
	$Camera2D.smoothing_speed = .6
	$Camera2D.position.y = -110

	
