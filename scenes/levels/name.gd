extends CanvasLayer

var name_string : String
onready var player_name = $Panel/name
var max_name = 10

func _ready():
	for c in get_node("Panel/GridContainer").get_children():
		c.connect("key_press", self, "_on_key_press")

func _on_Submit_pressed():
	if name_string.length() == 0:
		return
	globals.player_name = player_name.text
	analytics.objective_completed("entered a name", {
		"name": player_name.text,
		"elapsed_time": OS.get_ticks_msec()
		})
	
	global_ui.fade_out()
	globals.goto_scene("res://scenes/levels/intro.tscn")

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if name_string.length() <= max_name:
				name_string = name_string + char(event.unicode)
				player_name.text = name_string
			if event.scancode == 16777220:
				name_string.erase(name_string.length() - 1, 1)
				player_name.text = name_string
			if event.scancode == 16777221:
				_on_Submit_pressed()


func _on_key_press(event):
	print(event)
	if event == "BACKSPACE":
		name_string.erase(name_string.length() - 1, 1)
		player_name.text = name_string
	elif name_string.length() <= max_name:
		name_string = name_string + event
		player_name.text = name_string
