extends Node2D

func _ready():
	# does the player have the light spell? If not, we're not able to explore
	if !globals.is_lit:
		dialogue_controller.play_dialogue('library')
	else:
		dialogue_controller.play_dialogue('library lit')
		pass

func return_to_lounge():
	globals.player_spawn = 2
	globals.goto_scene("res://scenes/levels/lounge.tscn")

func read():
	globals.read_everything = true
