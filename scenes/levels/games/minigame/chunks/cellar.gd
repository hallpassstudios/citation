extends Node2D

onready var player = preload("res://scenes/player/top_down_runner.tscn")
onready var spawn = $"sort/spawner"

var quote_1 : bool
var quote_2 : bool
var door_open : bool
var played_dialogue
var shut : bool
var shut_2 : bool

# Called when the node enters the scene tree for the first time.
func _ready():
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

func _on_person_1_body_entered(body):
	if body.name == "top down runner":
		dialogue_controller.play_dialogue("person 1")

func _on_judge_body_entered(body):
	if body.name == "top down runner":
		dialogue_controller.play_dialogue("judge")

func _on_person_2_body_entered(body):
	if body.name == "top down runner":
		dialogue_controller.play_dialogue("person 2")

func _on_person_3_body_entered(body):
	if body.name == "top down runner":
		dialogue_controller.play_dialogue("person 3")

func _on_person_4_body_entered(body):
	if body.name == "top down runner":
		dialogue_controller.play_dialogue("person 4")

func _on_quote_1_area_body_entered(body):
	if body.name == "quotes" && !shut:
		body.sleeping = true
		quote_1 = true
		shut = true
	if body.name == "quotes2" && !shut:
		body.sleeping = true
		quote_2 = true
		shut = true
	if quote_1 && quote_2 && !door_open:
		$sort/door.visible = false
		$sort/door/collider.set_deferred("disabled", true)
		$sort/door/success.play()
		door_open = true

func _on_quote_2_area_body_entered(body):
	if body.name == "quotes" && !shut_2:
		body.sleeping = true
		quote_1 = true
		shut_2 = true
	if body.name == "quotes2" && !shut_2:
		body.sleeping = true
		quote_2 = true
		shut_2 = true
	if quote_1 && quote_2 && !door_open:
		$sort/door.visible = false
		$sort/door/collider.set_deferred("disabled", true)
		$sort/door/success.play()
		door_open = true

func next_level():
	globals.goto_scene("res://scenes/levels/games/minigame/chunks/classroom.tscn")
	
func _on_exit_body_entered(body):
	if body.name == "top down runner":
		globals.goto_scene("res://scenes/levels/games/minigame/chunks/cellar.tscn")
		if !played_dialogue:
			dialogue_controller.play_dialogue("cellar")
			played_dialogue = true
