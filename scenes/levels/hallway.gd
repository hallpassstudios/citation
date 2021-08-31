extends Node2D

onready var player_spawn = $"environment/player spawn"
var player = preload("res://scenes/player/top_down_player.tscn")
onready var advertisement = $canvas/advertisement

func _ready():
	print("hallway active")
	#spawn player
	player = player.instance()
	player_spawn.get_parent().add_child(player)
	globals.set_player(player)
	player.position = player_spawn.get_child(globals.player_spawn).position
	print("spawned player at: ", player.position)

func show_ad(value):
	if value:
		advertisement.visible = true
	else:
		advertisement.visible = false

func _on_slot_1_pressed():
	dialogue_controller.play_dialogue('illuminata cartridge')
