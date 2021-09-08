extends Node2D

onready var player_spawn = $"environment/player spawn"
var player = preload("res://scenes/player/top_down_player.tscn")

func _ready():
	print("hallway active")
	#spawn player
	player = player.instance()
	player_spawn.get_parent().add_child(player)
	globals.set_player(player)
	player.position = player_spawn.get_child(globals.player_spawn).position
	print("spawned player at: ", player.position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
