extends Area2D


func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("click") || event is InputEventScreenTouch:
		print("Clicked")
		print(self)
		get_child(0).clicked_object = self.name
		
		# when colliding, play the dialoge for the clicked object


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
