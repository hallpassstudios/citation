extends CanvasLayer

signal use_move_vector
var move_vector
var joystick_active
var touchscreen_active

func _input(event):
	if event is InputEventScreenTouch:
		# if the event is on the left side of the screen:
		var screenSize = Vector2(0,0)
		screenSize.x = get_viewport().get_visible_rect().size.x
		if event.position.x <= screenSize.x/2 && !touchscreen_active:
			$TouchScreenButton.position = event.position - Vector2(64,64)
			$TouchScreenButton.visible = true
			touchscreen_active = true
	if event is InputEventScreenDrag && touchscreen_active:
		move_vector = calculate_move_vector(event.position)
		joystick_active = true
		$"touch sprite".position = event.position
		$"touch sprite".visible = true

	if event is InputEventScreenTouch:
		if event.pressed == false:
			joystick_active = false
			$TouchScreenButton.visible = false
			$"touch sprite".visible = false
			touchscreen_active = false
			
func _physics_process(delta):
	if joystick_active:
		emit_signal("use_move_vector", move_vector)
		
func calculate_move_vector(event_position):
	var texture_center = $TouchScreenButton.position + Vector2(64,64)
	return (event_position - texture_center).normalized()
