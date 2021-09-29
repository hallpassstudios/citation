extends Node2D

onready var joe = $"environment/interactable objects/shade"
onready var flame = $"environment/static objects/flame"
onready var shade_dialoge = $"shade collider"
var animation_finished

func _ready():
	VisualServer.set_default_clear_color(Color(0,0,0,0.0))
	# does the player have the light spell? If not, we're not able to explore
	if !globals.is_lit && !globals.caught_joe:
		dialogue_controller.play_dialogue('library')
		joe.visible = false
		flame.visible = false

	if globals.is_lit && !globals.caught_joe:
		dialogue_controller.play_dialogue('library lit')
		joe.visible = false
		flame.visible = false

	if globals.caught_joe:
		dialogue_controller.play_dialogue('library shade')
		#activate the shade character
		joe.visible = true
		flame.visible = true
		$"environment/interactable objects/shade".play("default")

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

func go_to_credits():
	globals.goto_scene("res://scenes/levels/credits.tscn")
	
func shade_spooky():
	$"environment/interactable objects/shade".play("spooky")
