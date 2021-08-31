extends KinematicBody2D

#player variables
export (int) var speed = 800
export (int) var jump_speed = -250
export (int) var gravity = 1000
export (int, 0, 5000) var push = 1000

# realtime
var velocity = Vector2.ZERO
var jumping = false
var shooting
var touch_input : Vector2
var can_jump = false
var can_shoot = false

onready var animated_sprite = $CollisionShape2D/AnimatedSprite
var bullet = preload("res://scenes/props/bullet.tscn")
onready var wand = $CollisionShape2D/wand/Sprite
onready var camera = $Camera2D

# shooting-related
var bullet_count = 0
var max_bullets = 100

func _ready():
	#center the camera
	camera.position = animated_sprite.position
	#get_tree().set_debug_collisions_hint(true) 
	#get_tree().is_debugging_collisions_hint()
	pass

func _on_left_button_pressed():
	touch_input = Vector2(-1,0)

func _on_right_button_pressed():
	touch_input = Vector2(1,0)
	
func get_input():
	velocity.x = 0
	
	# keyboard / mouse input
	if Input.is_action_pressed("walk_right"):
		velocity.x += speed

	if Input.is_action_pressed("walk_left"):
		velocity.x -= speed

	var jump = Input.is_action_just_pressed('jump')
	
	if touch_input != Vector2.ZERO:
		velocity.x += speed * touch_input.x
	if jump and is_on_floor():
		print("jumping")
		animated_sprite.play("jump")
		jumping = true
		velocity.y = jump_speed
	
	# get our cursor
	var mouse_position = get_global_mouse_position()
	
	# have our wand follow the cursor
	wand.get_parent().look_at(get_global_mouse_position())
	
	# flippin the sprite
	if position.x < mouse_position.x:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false

func _input(event):
	# keyboard and mouse
	if(event.is_action_pressed("fire")):
		print("fire!")
		if !shooting:
			shoot(event)
		shooting = true
	elif(event.is_action_released("fire")):
		shooting = false

	if event is InputEventScreenTouch:
		if event.is_pressed():
			shoot(event)

func shoot(event):
	if !globals.can_shoot:
		return
	# these are our mobile button checks so we don't shoot when pressing them!
	if event.position.y + 25 > globals.right_button.get_global_transform_with_canvas().origin.y && event.position.x < globals.right_button.get_global_transform_with_canvas().origin.x:
		return
	
	if event.position.x + 25 > globals.jump_button.get_global_transform_with_canvas().origin.x && event.position.y + 5 > globals.jump_button.get_global_transform_with_canvas().origin.y:
		return
		
	if get_tree().get_nodes_in_group("bullets").size() <= max_bullets:
		var b = bullet.instance()
		var dir
		if orientation_check.platform == "mobile":
			dir = wand.global_position.direction_to(get_canvas_transform().affine_inverse().xform(event.position))
		if orientation_check.platform == "desktop":
			dir = wand.global_position.direction_to(get_global_mouse_position())
		print("angle to mouse position is: ", dir)
		b.start(wand.global_position, dir)
		print("wand position: ", wand.position)
		get_parent().add_child(b)

func _physics_process(delta):
	get_input()
	
	# movement
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP,false, 4, PI/4, false)
	# after calling move_and_slide()
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("answers"):
			collision.collider.apply_central_impulse(-collision.normal * push)
	
	# jumping?
#	if Input.is_action_just_pressed("jump") || !can_jump:
#		if is_on_floor():
#			velocity.y = jump_speed
#			can_jump = true
#
	# animation
	if velocity.x > 0 && is_on_floor():
		animated_sprite.speed_scale = 1
		animated_sprite.flip_h = false
		animated_sprite.play("walk")
	elif velocity.x < 0 && is_on_floor():
		animated_sprite.speed_scale = 1
		animated_sprite.flip_h = true
		animated_sprite.play("walk")
	elif velocity.x == 0 && is_on_floor():
		animated_sprite.speed_scale = 1
		animated_sprite.play("idle")
	elif velocity.x < 0 && !is_on_floor():
		animated_sprite.speed_scale = 1
		animated_sprite.flip_h = false
		animated_sprite.play("jump")
	elif velocity.x > 0 && !is_on_floor():
		animated_sprite.flip_h = true
		animated_sprite.speed_scale = 2
		animated_sprite.play("jump")

func _on_left_button_released():
	touch_input = Vector2.ZERO
	
func _on_right_button_released():
	touch_input = Vector2.ZERO

func _on_up_button_pressed():
	can_jump = false

func _on_up_button_released():
	can_jump = true

func _on_death_body_entered(body):
	if body.name == "player": #or if it's an answer
		print("player fell")
		global_ui.fade_out()
		yield(get_tree().create_timer(2.0), "timeout")
		get_tree().reload_current_scene()
		global_ui.fade_in()
	if body.is_in_group("correct"):
		get_tree().reload_current_scene()
	#if body.name


func _on_Area2D_body_entered(body):
	if body.name == "player": #or if it's an answer
		print("player fell")
		global_ui.fade_out()
		yield(get_tree().create_timer(1.0), "timeout")
		get_tree().reload_current_scene()
		global_ui.fade_in()
	if body.is_in_group("correct"):
		get_tree().reload_current_scene()
