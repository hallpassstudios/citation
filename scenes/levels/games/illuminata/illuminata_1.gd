extends Node2D

onready var camera
onready var spawn = $"player spawn"
var player = preload("res://scenes/player/side_scroll_player.tscn")

func _ready():
	
	# spawn player
	player = player.instance()
	add_child(player)
	player.position = spawn.position
	camera = player.get_child(0)
	
	# play bg music
	background_music.base.stop()
	background_music.bad.play()

	# fade in the level
	global_ui.fade_in()
	yield(get_tree().create_timer(2.0), "timeout")

	# play welcome
	dialogue_controller.play_dialogue('illuminata tutorial')
	camera.zoom_in(player.position - camera.get_camera_position())


func _on_Area2D_body_entered(body):
	if body.name == "player":
		dialogue_controller.play_dialogue('illuminata movement 2')

func _on_Area2D2_body_entered(body):
	if body.name == "player":
		dialogue_controller.play_dialogue('illuminata movement 3')

func _on_Area2D3_body_entered(body):
		if body.name == "player":
			dialogue_controller.play_dialogue('illuminata movement 4')

func _on_Area2D4_body_entered(body):
	if body.name == "player":
		dialogue_controller.play_dialogue('illuminata movement')

# mobile controls
func _on_left_button_pressed():
	player.left_pressed()

func _on_right_button_pressed():
	player.right_pressed()

func _on_left_button_released():
	player.left_released()

func _on_right_button_released():
	player.right_released()
