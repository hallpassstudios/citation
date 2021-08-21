extends Node2D

var tutorial_scene = preload("res://scenes/ui/tutorial.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	
	# fade in the level
	global_ui.fade_in()
	yield(get_tree().create_timer(2.0), "timeout")
	
	
	# show the tutorial screen if we need it
	if !globals.tutorial_played:
		yield(get_tree().create_timer(0.1), "timeout")
		
		# show the tutorial scene
		get_parent().add_child(tutorial_scene.instance())
		get_tree().paused = true
		
func _process(delta):
	if get_tree().get_nodes_in_group("correct").size() == 0:
		# we destroyed the correct answer, show a message and restart the level
		get_tree().reload_current_scene()
