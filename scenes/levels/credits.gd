extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# dialogue_controller.play_dialogue('credits')
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$CanvasLayer/TextureRect/story.rect_position.y -= 10 * delta


func _on_TextureRect_gui_input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			globals.goto_scene("res://scenes/levels/start.tscn")
