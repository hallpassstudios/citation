extends Node2D

onready var player = preload("res://scenes/player/top_down_runner.tscn")

func _ready():
	global_ui.fade_in()
	yield(get_tree().create_timer(1), "timeout")
	var current_player = player.instance()
	globals.player = current_player

	# tell our player what the current scene is
	globals.current_scene = self
	dialogue_controller.play_dialogue("did not cheat")
	
func go_to_final():
	globals.goto_scene("res://scenes/levels/games/minigame/chunks/final.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
