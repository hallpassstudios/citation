extends Node2D

var camera = preload("res://scenes/utilities/camera.tscn")
var player = preload("res://scenes/player/top_down_player.tscn")
# onready var spawn_points = $"player spawn"

func _ready():
	
	#spawn player
	player = player.instance()
	add_child(player)
	globals.set_player(player)
	player.position = get_child(globals.player_spawn).position
