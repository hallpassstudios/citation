extends Node2D

export(String) var travel_to
export(String) var object_name
export(bool) var has_dialogue
export(String) var dialogue
export(String) var dialogue_variable_name
export(int) var dialogue_variable_value
export(float) var outline_size
export(int) var spawn_point

var already_inside : bool

enum type {
	DOOR = 0,
	OBJECT = 1,
	NPC = 2
}

var clicked_object

export(type) var TYPE
var shape
var object

func _on_interactable_input_event(viewport, event, shape_idx):
	# mouse movement input
	if event.is_action_pressed("click") || event is InputEventScreenTouch:
		match TYPE:
			0:
				globals.player.travel(true)
				globals.player.interact(false) # not interacting, traveling
				outline(true)
				# are we already in the area?
			1:
				globals.player.interact(true) # tell the player we'll be interacting
				outline(true)
			2:
				outline(true)
			_:
				print("nothing")

func outline(value):
	if value:
		# we should access our parent sprite and highlight the object
		get_child(0).material.set_shader_param("width", outline_size)
	else: 
		get_child(0).material.set_shader_param("width", 0)

func _on_interactable_body_entered(body):
	print("entering...", body.name)
	if body.name == "top down player":
		already_inside = true
		if clicked_object == get_parent().get_name():
			# play dialogue if we have it
			if has_dialogue:
				dialogue_controller.play_dialogue(dialogue)
			if globals.player.will_travel && globals.desk_interact:
				globals.player_spawn = spawn_point
				globals.goto_scene("res://scenes/levels/" + travel_to + ".tscn")
				globals.player.travel(false)
			if !globals.desk_interact && !object_name == "desk" && !object_name == "joe":
				dialogue_controller.play_dialogue('interact')
			if globals.caught_joe && self.get_parent().name != "door to library" && globals.current_scene.name == "lounge":
				dialogue_controller.play_dialogue('find joe')

func _on_interactable_body_exited(body):
	if body.name == "top down player":
		get_child(0).material.set_shader_param("width", 0)
		globals.player.interact(false) 
		already_inside = false

func inside():
	if clicked_object == get_parent().get_name():
			# play dialogue if we have it
			if has_dialogue:
				dialogue_controller.play_dialogue(dialogue)
			if globals.player.will_travel && globals.desk_interact:
				globals.player_spawn = spawn_point
				globals.goto_scene("res://scenes/levels/" + travel_to + ".tscn")
			if !globals.desk_interact && !object_name == "desk" && !object_name == "joe":
				dialogue_controller.play_dialogue('interact')
