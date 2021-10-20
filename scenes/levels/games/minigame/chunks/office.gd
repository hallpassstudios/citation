extends Node2D

onready var player = preload("res://scenes/player/top_down_runner.tscn")
onready var spawn = $"sort/spawner"

# Called when the node enters the scene tree for the first time.
func _ready():
	# dialogue_controller.play_dialogue("cellar")
	# clear color to black
	VisualServer.set_default_clear_color(Color(0,0,0,0.0))
	# spawn player
	var current_player = player.instance()
	globals.player = current_player
	add_child(current_player)
	current_player.position = spawn.position
	analytics.set_objective("reprimanded")
	global_ui.fade_in()
	dialogue_controller.play_dialogue("chuck upset")
	analytics.caught()
	

func restart(title, subtitle):
	$HUD/restart.visible = true
	$HUD/restart/VBoxContainer/title.text = title
	$HUD/restart/VBoxContainer/subtitle.text = subtitle
	get_tree().paused = true

func _on_restart_pressed():
	print("pressed restart")
	$HUD/restart.visible = false
	get_tree().paused = false
	globals.goto_scene("res://scenes/levels/games/minigame/chunks/illuminata_classroom.tscn")

func _on_quit_pressed():
	globals.goto_scene("res://scenes/levels/dorm.tscn")

func restart_game(value):
	var title = value[0]
	var subtitle = value[1]
	restart(title,subtitle)
