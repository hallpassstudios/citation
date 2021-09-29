extends KinematicBody2D

var speed = 50
export (NodePath) var patrol_path
var patrol_points
var patrol_index = 0
var velocity = Vector2.ZERO
var player = null
var chasing : bool


enum states {PATROL, CHASE}
var state = states.PATROL

func _ready():
	if patrol_path:
		patrol_points = get_node(patrol_path).curve.get_baked_points()

func _physics_process(delta):
	choose_action()
	velocity = move_and_slide(velocity)

func choose_action():
	velocity = Vector2.ZERO
	var target
	match state:
		# Move along assigned path.
		states.PATROL:
			if !patrol_path:
				return
			target = patrol_points[patrol_index]
			if position.distance_to(target) < 1:
				patrol_index = wrapi(patrol_index + 1, 0, patrol_points.size())
				target = patrol_points[patrol_index]
			velocity = (target - position).normalized() * speed

		# Move towards player.
		states.CHASE:
			target = player.position
			if globals.is_lit:
				velocity = -(target - position).normalized() * speed
			else:
				velocity = (target - position).normalized() * speed

func _on_detect_radius_body_entered(body):
	if body.name == "top down runner":
		state = states.CHASE
		player = body

func _on_detect_radius_body_exited(body):
	if body.name == "top down runner":
		state = states.PATROL
		player = null

