extends CollisionObject2D

enum {
	DOOR,
	OBJECT
	NPC
}

var object : Object
var player : Object

func _on_interactables_body_entered(body):
	print("player entered area")
	print(globals.player)

func _on_interactables_input_event(viewport, event, shape_idx):
	# mouse movement input
	print("input event")
	if event.is_action_pressed("click") || event is InputEventScreenTouch:
		var shape_owner_id: int = shape_find_owner(shape_idx)
		object = shape_owner_get_owner(shape_owner_id)
		var collision_object := object as CollisionObject2D
		print(object, " has been interacted with!")
		print(collision_object) 
		var player = globals.player
		
		# tell our player that we're going to be interacting with something
		if player != null:
			# have our player move over to the object
			player.move_and_interact()
			player.state = 2 # interacting
		else:
			print("player not found!")
		# now we can match on the object
		match object.TYPE:
			DOOR:
				print("it's a door!")
				object.change_scene()
			OBJECT:
				print("it's an object")
				object.do_a_thing(true)
			_:
				print("nothing")
