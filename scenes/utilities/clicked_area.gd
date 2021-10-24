extends Area2D

var interactable

func _ready():
	connect("mouse_entered", self, "on_mouse_entered")
	connect("mouse_exited", self, "on_mouse_exited")

func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("click") || event is InputEventScreenTouch:
		print(self)
		get_child(0).clicked_object = self.name
		
		# we should travel if we click
		if get_child(0).already_inside:
			get_child(0).inside()
		
func on_mouse_entered():
	get_child(0).outline(true)

func on_mouse_exited():
	get_child(0).outline(false)
