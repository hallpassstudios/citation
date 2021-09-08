extends Node2D

onready var joe = $"environment/interactable objects/joe"
onready var flame = $"environment/static objects/flame"
onready var shade_dialoge = $"shade collider"

func _ready():
	# does the player have the light spell? If not, we're not able to explore
	if !globals.is_lit && !globals.caught_joe:
		dialogue_controller.play_dialogue('library')
	
	if globals.is_lit && !globals.caught_joe:
		dialogue_controller.play_dialogue('library lit')

	if globals.caught_joe:
		dialogue_controller.play_dialogue('library shade')
		#activate the shade character
		joe.visible = true
		flame.visible = true
		
		# play bg music
		background_music.base.stop()
		background_music.bad.play()

func return_to_lounge():
	globals.player_spawn = 2
	globals.goto_scene("res://scenes/levels/lounge.tscn")

func read():
	globals.read_everything = true

func _on_Area2D_body_entered(body):
	if body.name == "top down player" && globals.caught_joe:
		dialogue_controller.play_dialogue('final')
		
func fade_out():
	global_ui.fade_out()
	globals.goto_scene("res://scenes/levels/credits.tscn")

