extends Node2D

var tutorial_scene = preload("res://scenes/ui/tutorial.tscn")
# Called when the node enters the scene tree for the first time.

func _ready():
	# fade in the level
	global_ui.fade_in()
	# yield(get_tree().create_timer(2.0), "timeout")
	
	# play tutorial
	#dialogue_controller.play_dialogue('illuminata tutorial')

		
func _process(delta):
	if get_tree().get_nodes_in_group("correct").size() == 0:
		# we destroyed the correct answer, show a message and restart the level
		get_tree().reload_current_scene()
