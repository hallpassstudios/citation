extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_character_1_mouse_entered():
	$"environment/character 1".outline(true)
	
func _on_character_1_mouse_exited():
	$"environment/character 1".outline(false)

func _on_character_2_mouse_entered():
	$"environment/character 2".outline(true)

func _on_character_2_mouse_exited():
	$"environment/character 2".outline(false)

func _on_character_3_mouse_entered():
	$"environment/character 3".outline(true)

func _on_character_3_mouse_exited():
	$"environment/character 3".outline(false)

func _on_character_1_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("click"):
		globals.active_char = 1
		globals.goto_scene("res://scenes/levels/name.tscn")
	
	if event is InputEventScreenTouch:
		$"environment/character 1".outline(true)
		globals.active_char = 1
		globals.goto_scene("res://scenes/levels/name.tscn")


func _on_character_2_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("click"):
		globals.active_char = 2
		globals.goto_scene("res://scenes/levels/name.tscn")
	
	if event is InputEventScreenTouch:
		$"environment/character 1".outline(true)
		globals.active_char = 2
		globals.goto_scene("res://scenes/levels/name.tscn")

func _on_character_3_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("click"):
		globals.active_char = 3
		globals.goto_scene("res://scenes/levels/name.tscn")
	
	if event is InputEventScreenTouch:
		$"environment/character 1".outline(true)
		globals.active_char = 3
		globals.goto_scene("res://scenes/levels/name.tscn")
