extends Node2D

onready var player = preload("res://scenes/player/top_down_runner.tscn")
onready var spawn = $"sort/spawner"

# Called when the node enters the scene tree for the first time.
func _ready():
	# clear color to black
	VisualServer.set_default_clear_color(Color(0,0,0,0.0))
	# spawn player
	var current_player = player.instance()
	globals.player = current_player
	add_child(current_player)
	current_player.position = spawn.position
	global_ui.fade_in()
	dialogue_controller.play_dialogue("outside 1")
	


func _on_exit_body_entered(body):
	if body.name == "top down runner":
		analytics.objective_completed("completed level 1", {
			"elapsed_time": OS.get_ticks_msec()
		})
		globals.goto_scene("res://scenes/levels/games/minigame/chunks/house.tscn")

