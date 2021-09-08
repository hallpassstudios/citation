extends Node2D

var camera = preload("res://scenes/utilities/camera.tscn")
onready var player_spawn = $"environment/player spawn"
var player = preload("res://scenes/player/top_down_player.tscn")
# onready var spawn_points = $"player spawn"

func _ready():
	
	#play musix
	if !background_music.base.playing:
		background_music.base.play()
		background_music.excellent.stop()
		background_music.bad.stop()
	# fade in the level
	if globals.is_lit:
		global_ui.fade_in()
	# yield(get_tree().create_timer(1.0), "timeout")
	
	#spawn player
	player = player.instance()
	add_child(player)
	globals.set_player(player)
	player.position = player_spawn.get_child(globals.player_spawn).position
	# play tutorial if not played already
	if !globals.tutorial_played:
		dialogue_controller.play_dialogue('intro')
		globals.tutorial_played = true
	
	if globals.illuminata_completed:
		dialogue_controller.play_dialogue('return to dorm')
		globals.illuminata_completed = false
		
func play_game(value):
	get_tree().paused = false
	print("playing the game now", value[0])
	global_ui.fade_out()
	# remove the inventory item
	yield(get_tree().create_timer(3.0), "timeout")
	background_music.base.stop()
	background_music.bad.play()
	globals.goto_scene("res://scenes/levels/games/illuminata/illuminata_1.tscn")

func desk_interact():
	globals.desk_interact = true
