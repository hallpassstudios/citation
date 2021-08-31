extends Node

export(String) var travel_to
export(String) var object_name
export(bool) var has_dialogue
export(String) var dialogue
export(String) var dialogue_variable_name
export(int) var dialogue_variable_value
export(float) var outline_size
export(NodePath) var sprite
export(int) var spawn_point

enum type {
	DOOR,
	OBJECT
	NPC
}

export(type) var TYPE

signal on_interact

func interact(value):
	# play dialogue if we have it
	if value:
		if has_dialogue:
			dialogue_controller.play_dialogue(dialogue)

func outline(value):
	# we should access our parent sprite and highlight the object
	get_node(sprite).material.set_shader_param("outLineSize", outline_size)
	
	# then we should turn if off when we get done interacting
	if(!value):
		get_node(sprite).material.set_shader_param("outLineSize", 0)

func say_a_thing():
	dialogue_controller.play_dialogue(dialogue)

func change_scene():
	globals.player_spawn = spawn_point
	globals.goto_scene("res://scenes/levels/" + travel_to + ".tscn")
