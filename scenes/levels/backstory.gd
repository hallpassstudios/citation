extends Node2D

var loading : bool = false
func _ready():
	VisualServer.set_default_clear_color(Color(0.04,0.04,0.04,0.0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$CanvasLayer/TextureRect/story.rect_position.y -= 12 * delta
	if $CanvasLayer/TextureRect/story.rect_position.y < -750:
		$CanvasLayer/TextureRect/story.rect_position.y = 220

func _on_TextureRect_gui_input(event):
		if event.is_action_pressed("click") && !loading:
			loading = true
			globals.goto_scene("res://scenes/levels/start.tscn")
		if event is InputEventScreenTouch:
			if event.pressed == true && !loading:
				loading = true
				globals.goto_scene("res://scenes/levels/start.tscn")
