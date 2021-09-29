extends Node2D

onready var player = preload("res://scenes/player/top_down_runner.tscn")
onready var spawn = $"sort/spawner"

var key_progress = 0
var has_key : bool
var key_1
var key_2
var key_3
var spike_count
var played_door_sound : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	# clear color to black
	VisualServer.set_default_clear_color(Color(0,0,0,0.0))
	# spawn player
	var current_player = player.instance()
	globals.player = current_player
	add_child(current_player)
	current_player.position = spawn.position
	# play dialogue
	dialogue_controller.play_dialogue("house")


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
	globals.goto_scene("res://scenes/levels/start.tscn")

func _on_trap_body_entered(body):
	if body.name == "top down runner":
		print("you're trapped")
		$spikies.gravity_scale = 10

func _on_Area2D_body_entered(body):
	if body.name == "top down runner":
		globals.stats.spike_deaths += 1
		analytics.objective_completed("spike deaths", {
			"spike deaths": globals.stats.spike_deaths
		})
		restart("OUCH SPIKES!", "academic integrity keeps you sharper than these spikes!")

func _on_table_body_entered(body):
	if body.name == "top down runner":
		key_progress += 1
		if key_progress == 3:
			$key.visible = true
			$key/success.play()

func _on_key_body_entered(body):
	if body.name == "top down runner":
		has_key = true
		$key.visible = false

func _on_door_body_entered(body):
	if body.name == "top down runner":
		if has_key && !played_door_sound:
			$door.visible = false
			$door/StaticBody2D/collider.set_deferred("disabled", true)
			$door.monitoring = false
			$door/door_click.play()
			played_door_sound = true
			
			

func _on_table_1_body_entered(body):
	if body.name == "top down runner":
		globals.stats.table_flips += 1
		analytics.objective_completed("table flips", {
		"table flips": globals.stats.table_flips
		})
	if body.name == "top down runner" && !key_1:
		key_1 = true
		key_progress += 1
		if key_progress == 3:
			$key.visible = true
			$key/success.play()

func _on_table_2_body_entered(body):
	if body.name == "top down runner":
		globals.stats.table_flips += 1
		analytics.objective_completed("table flips", {
		"table flips": globals.stats.table_flips
		})
	if body.name == "top down runner" && !key_2:
		key_2 = true
		key_progress += 1
		if key_progress == 3:
			$key.visible = true
			$key/success.play()

func _on_table_3_body_entered(body):
	if body.name == "top down runner":
		globals.stats.table_flips += 1
		analytics.objective_completed("table flips", {
		"table flips": globals.stats.table_flips
		})
	if body.name == "top down runner" && !key_3:
		key_3 = true
		key_progress += 1
		if key_progress == 3:
			$key.visible = true
			$key/success.play()

func _on_exit_body_entered(body):
	if body.name == "top down runner":
		analytics.objective_completed("completed level 2", {
			"elapsed_time": OS.get_ticks_msec(),
			"spike deaths": globals.stats.spike_deaths
		})
		globals.goto_scene("res://scenes/levels/games/minigame/chunks/cellar.tscn")
