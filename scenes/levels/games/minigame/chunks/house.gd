extends Node2D

onready var player = preload("res://scenes/player/top_down_runner.tscn")
onready var spawn = $"sort/spawner"

var key_progress = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	dialogue_controller.play_dialogue("house")
	# clear color to black
	VisualServer.set_default_clear_color(Color(0,0,0,0.0))
	# spawn player
	var current_player = player.instance()
	globals.player = current_player
	add_child(current_player)
	current_player.position = spawn.position

func restart(title, subtitle):
	$HUD/restart.visible = true
	$HUD/restart/VBoxContainer/title.text = title
	$HUD/restart/VBoxContainer/subtitle.text = subtitle
	get_tree().paused = true

func _on_restart_pressed():
	print("pressed restart")
	$HUD/restart.visible = false
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_pressed():
	globals.goto_scene("res://scenes/levels/dorm.tscn")

func _on_trap_body_entered(body):
	if body.name == "top down runner":
		print("you're trapped")
		$spikies.gravity_scale = 10

func _on_Area2D_body_entered(body):
	if body.name == "top down runner":
		restart("OUCH SPIKES!", "academic integrity keeps you sharper than these spikes!")

func _on_table_body_entered(body):
	if body.name == "top down runner":
		key_progress += 1
		if key_progress == 3:
			$key.visible = true
