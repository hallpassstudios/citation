extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	VisualServer.set_default_clear_color(Color(0.0,0.0,0.0,0.0))
	# dialogue_controller.play_dialogue("credits")
	global_ui.fade_in()
	pass
	analytics.objective_completed("completed credits", {
		"elapsed_time": OS.get_ticks_msec()
		})


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$CanvasLayer/TextureRect/story.rect_position.y -= 1 * delta
	if $CanvasLayer/TextureRect/story.rect_position.y <= 0:
		analytics.objective_completed("read credits", {
		"elapsed_time": OS.get_ticks_msec()
		})
