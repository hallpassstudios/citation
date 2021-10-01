extends Node

signal key_press

func _ready():
	connect("gui_input", self, "_on_gui_input")

func _on_gui_input(event):
	if event.is_action_pressed("click") || (event is InputEventScreenTouch and event.pressed):
		emit_signal("key_press", name)
