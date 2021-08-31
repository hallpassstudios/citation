extends Node2D

onready var camera = $player/Camera2D
onready var player = $player

func _ready():
	# fade in the level
	global_ui.fade_in()
	camera.zoom_in(player.position - camera.get_camera_position())
	yield(get_tree().create_timer(2.0), "timeout")
	globals.illuminata_completed = true
