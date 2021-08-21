extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Button_pressed():
	print("pressed")
	get_tree().reload_current_scene()


func _on_Button_mouse_entered():
	print("mouse entered")
