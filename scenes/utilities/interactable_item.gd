extends Node

export(String) var travel_to

enum type {
	DOOR,
	OBJECT
	NPC
}

export(type) var TYPE

func change_scene():
	globals.goto_scene("res://Levels/" + travel_to + ".tscn")

func do_a_thing(value : bool):
	print("I can do a thing because I am an ", TYPE)
	
	# we should access our parent sprite and highlight the object
	var item_sprite = get_child(0)
	item_sprite.material.set_shader_param("outLineSize", 0.02)
	
	# then we should turn if off when we get done interacting
	if(!value):
		item_sprite.material.set_shader_param("outLineSize", 0)
