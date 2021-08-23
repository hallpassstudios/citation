extends Node2D

var camera = preload("res://scenes/utilities/camera.tscn")
onready var player_spawn = $"player spawn"
var player = preload("res://scenes/player/top_down_player.tscn")

func _ready():
	#spawn player
	player = player.instance()
	add_child(player)
	globals.set_player(player)
	player.position = player_spawn.position

func _on_interactables_mouse_entered():
	print("mouse")

