extends Node2D

var camera = preload("res://scenes/utilities/camera.tscn")
onready var player_spawn = $"environment/player spawn"
var player = preload("res://scenes/player/top_down_player.tscn")
# onready var spawn_points = $"player spawn"
var played_quiz : bool = false

func _ready():
	if globals.is_lit:
		global_ui.fade_in()

	#spawn player
	player = player.instance()
	add_child(player)
	globals.set_player(player)
	player.position = player_spawn.get_child(globals.player_spawn).position
	# play tutorial if not played already
	if !globals.tutorial_played:
		yield(get_tree().create_timer(1.0), "timeout")
		dialogue_controller.play_dialogue('intro')
		globals.tutorial_played = true
	
	if globals.completed_quiz:
		yield(get_tree().create_timer(1.0), "timeout")
		dialogue_controller.play_dialogue('dorm quiz completed')
		globals.completed_quiz = false
		
	if globals.illuminata_completed:
		yield(get_tree().create_timer(1.0), "timeout")
		dialogue_controller.play_dialogue('return to dorm')
		globals.illuminata_completed = false
		
func play_game(value):
	get_tree().paused = false
	print("playing the game now ", value[0])
	global_ui.fade_out()
	# remove the inventory item
	# yield(get_tree().create_timer(3.0), "timeout")
	
	if value[0] == "illuminata":
		globals.goto_scene("res://scenes/levels/games/minigame/chunks/outside.tscn")
	
	if value[0] == "quiz":
		globals.goto_scene("res://scenes/levels/games/quiz/quiz.tscn")

func desk_interact():
	globals.desk_interact = true

func open_url():
	OS.shell_open("https://hallpass.games/2021/10/18/bean-king-v-dream-school-case-description/")

	
