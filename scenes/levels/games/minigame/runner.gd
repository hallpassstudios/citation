extends KinematicBody2D

export var snap := false
export var move_speed := 250
export var jump_force := 300
export var gravity := 900
export var slope_slide_threshold := 50.0

var velocity := Vector2()

func _ready():
	globals.player = self

func _physics_process(delta):
	$sprite.speed_scale = move_speed / 200
	var direction_x := Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = direction_x * move_speed
	velocity.y += gravity * delta
	
	var snap_vector = Vector2(0, 32) if snap else Vector2()
	velocity = move_and_slide_with_snap(velocity, snap_vector, Vector2.UP, slope_slide_threshold, 4, deg2rad(46))
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.is_in_group("obstacles"):
			get_tree().get_root().get_node("main").restart()
	
	if is_on_floor():
		velocity.y = 0
		$sprite.play("walk")
		$sprite.flip_h = false

	var just_landed := is_on_floor() and not snap
	if just_landed:
		snap = true	

func jump():
	$sprite.play("jump")
	$sprite.flip_h = true
	velocity.y = -jump_force
	snap = false
