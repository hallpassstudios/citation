extends CollisionObject2D

enum type {
	DOOR,
	OBJECT
	NPC
}

var object : Object
var shape 

func _on_interactable_zone_input_event(viewport, event, shape_idx):
	# mouse movement input
	if event.is_action_pressed("click") || event is InputEventScreenTouch:
		var shape_owner_id: int = shape_find_owner(shape_idx)
		object = shape_owner_get_owner(shape_owner_id)
		var collision_object := object as CollisionObject2D
		# store this shape so we can compare when entering
		shape = shape_idx
		# now we can match on the object
		match object.TYPE:
			type.DOOR:
				globals.player.travel(true)
				globals.player.interact(false) # not interacting
				object.outline(true)
				# are we already in the area?
			type.OBJECT:
				globals.player.interact(true) # tell the player we'll be interacting
				object.outline(true)
			type.NPC:
				object.outline(true)
			_:
				print("nothing")

func _on_interactable_zone_body_shape_entered(body_rid, body, body_shape, local_shape):
	# check to make sure we're entering the correct collider
	if local_shape == shape:
		if globals.player.will_interact:
			object.interact(true)
		if globals.player.will_travel:
			object.change_scene()

func _on_interactable_zone_body_shape_exited(body_rid, body, body_shape, local_shape):
	if local_shape == shape:
		print("player left")
		if !object:
				return
		match object.TYPE:
			type.OBJECT:
				# print("moved away, doing the false thing")
				object.outline(false)
				object.interact(false)
				globals.player.interact(false) # not interacting
			type.DOOR:
				# print("moved away, doing the false thing")
				object.interact(false)
				globals.player.interact(false) # not interacting
			_:
				print("nothing")


func _on_desk2_input_event(viewport, event, shape_idx):
	pass # Replace with function body.


func _on_board_input_event(viewport, event, shape_idx):
	pass # Replace with function body.
