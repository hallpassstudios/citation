extends Node

export(String) var travel_to

enum type {
	DOOR,
	OBJECT
	NPC
}

export(type) var TYPE

# Called when the node enters the scene tree for the first time.

func _ready():
	get_tree().set_debug_collisions_hint(true) 
	get_tree().is_debugging_collisions_hint()


func change_scene():
	globals.goto_scene("res://Levels/" + travel_to + ".tscn")

func do_a_thing(value : bool):
	print("I can do a thing because I am an ", TYPE)
	
	# we should access our parent sprite and highlight the object
	var item_sprite = get_child(0)
	item_sprite.material.set_shader_param("outLineSize", 0.003)
	
	# then we should turn if off when we get done interacting
	if(!value):
		item_sprite.material.set_shader_param("outLineSize", 0)
