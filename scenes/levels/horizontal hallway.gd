extends Node2D

signal perform_audio_action(action)

onready var player_spawn = $"environment/player spawn"
var player = preload("res://scenes/player/top_down_player.tscn")

func _ready():
	print("hallway active")
	#spawn player
	player = player.instance()
	player_spawn.get_parent().add_child(player)
	globals.set_player(player)
	player.position = player_spawn.get_child(globals.player_spawn).position
	connect('perform_audio_action', get_node('/root/audio_manager'), '_on_perform_audio_action')
	print("spawned player at: ", player.position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !globals.caught_joe:
		emit_signal('perform_audio_action', {'fade_out':{}})
