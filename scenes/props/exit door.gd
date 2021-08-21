extends Sprite

export (String) var next_level
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		if get_tree().get_nodes_in_group("incorrect").size() == 0:
			global_ui.fade_out()
			yield(get_tree().create_timer(2.0), "timeout")
			globals.goto_scene("res://scenes/levels/" + next_level + ".tscn")
