extends KinematicBody2D

var speed = 200
var damage = 3
var velocity = Vector2()
var _position_last_frame := Vector2()
export (int, 0, 100) var push = 1

var hit = false

func start(pos, dir):
	# rotation = dir
	position = pos
	velocity = dir * speed
	
func _physics_process(delta):
	velocity = move_and_slide(velocity, Vector2.UP,false, 4, PI/4, false)
	
	# after calling move_and_slide()
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("answers"):
			var localCollisionPos = collision.position - collision.collider.position;
			collision.collider.apply_impulse(localCollisionPos, -collision.normal * push * speed)
			collision.collider.hit(damage)
			queue_free()
	var _position_last_frame := Vector2()

func _on_VisibilityNotifier2D_screen_exited():
	print("killing")
	queue_free()
