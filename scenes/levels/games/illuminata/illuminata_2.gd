extends Node2D

onready var spell = $"spell"
var area_1_played = false
var area_2_played = false
var area_3_played = false
var area_4_played = false
onready var camera = $player/Camera2D
onready var player = $player

func _ready():
	# fade in the level
	global_ui.fade_in()
	camera.zoom_in(player.position - camera.get_camera_position())
	yield(get_tree().create_timer(2.0), "timeout")
	# play welcome
	dialogue_controller.play_dialogue('illuminata 2 tutorial')
	
	

func _on_Area2D_body_entered(body):
	if body.name == "player" && !area_1_played:
		dialogue_controller.play_dialogue('illuminata 2 movement')
		area_1_played = true

func _on_spell_body_entered(body):
	if body.name == "player" && !area_2_played:
		
		dialogue_controller.play_dialogue('illuminata 2 shoot')
		globals.can_shoot = true
		globals.is_lit = true
		spell.visible = false
		area_2_played = true

func _on_zoom_out_body_entered(body):
	if body.name == "player" && !area_3_played:
			camera.zoom_out(Vector2(0,0))
			yield(get_tree().create_timer(1.0), "timeout")
			dialogue_controller.play_dialogue('illuminata 2 shoot 2')
			area_3_played = true
			globals.is_lit = true


func _on_Area2D2_body_entered(body):
	if body.name == "player" && !area_4_played:
		camera.zoom_in(player.position - camera.get_camera_position())
		dialogue_controller.play_dialogue('illuminata 2 end')
		area_4_played = true
		globals.illuminata_completed = true